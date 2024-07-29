package com.icia.guree.controller;

import com.icia.guree.dao.FileDao;
import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.BoardFileDto;
import com.icia.guree.entity.SearchDto;
import com.icia.guree.service.BoardService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Controller
public class BoardController {
    @Autowired
    private BoardService bSer;

    @Autowired
    private FileDao pDao;

    // 경매 물품 올리기 페이지로
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/board/auctionRegister")
    public String auctionRegister(Model model) {
        List<String> cateList = bSer.cateList();
        model.addAttribute("cateList", cateList);

        return "board/auctionRegister";
    }

    // 경매 물품 올리기
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/board/productRegister")
    public String productRegister(BoardDto bDto, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            bDto.setSb_id(userDetails.getUsername());
            log.info("======================" + bDto.toString());
            boolean result = bSer.productRegister(bDto, session);
            if (result) {
                return "redirect:/board/auctionList";
            }
            return "redirect:/board/auctionRegister";
        }

        return "redirect:/member/login";
    }

    //경매 리스트로
    @GetMapping("/board/auctionList")
    public String auctionList(BoardDto bDto, Model model) {
        int totalItems = bSer.countAuctionItems(bDto);
        int totalPages = (int) Math.ceil((double) totalItems / BoardService.LISTCNT);

        if ( bDto.getPageNum()==null || bDto.getPageNum() < 1) {
            bDto.setPageNum(1);
        } else if (bDto.getPageNum() > totalPages) {
            bDto.setPageNum(totalPages);
        }

        int currentGroup = (bDto.getPageNum()- 1) / BoardService.PAGECOUNT;
        int startPage = currentGroup * BoardService.PAGECOUNT + 1;
        int endPage = Math.min(startPage + BoardService.PAGECOUNT - 1, totalPages);

        List<BoardDto> bList = bSer.auctionList(bDto);
        List<String> cateList = bSer.cateList();
        model.addAttribute("cateList", cateList);
        log.info("========-=-=-=-=-=-=-=-=-=-=============" + bList.toString());
        if (!bList.isEmpty()) {
            model.addAttribute("bList", bList);
            model.addAttribute("currentPage", bDto.getPageNum());
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("pageCount", BoardService.PAGECOUNT);
        }
        return "board/auctionList";
    }

    // 경매 자세히보기 페이지로
    @GetMapping("/board/auctionDetail")
    public String auctionDetail(BoardDto bDto,Model model, RedirectAttributes redirectAttributes) {
        BoardDto detail = bSer.auctionDetail(bDto);
        LocalDateTime now = LocalDateTime.now();
        log.info("=====================" + now);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime later = LocalDateTime.parse(detail.getSb_timer(), formatter);

        log.info("========xxxxxx=============" + now);
        log.info("======zzzzzzz===============" + later);

        boolean ifafter = now.isAfter(later);
        log.info("======zzzzzzz===============" + ifafter);
        if (ifafter) {
            bSer.auctionEnd(bDto);
            redirectAttributes.addFlashAttribute("msg", "이미 완료된 경매입니다.");
            return "redirect:/board/auctionList";
        }

        List<BoardFileDto> file = bSer.getFile(bDto);
        log.info("=====================" + file.toString());
        log.info("======================" + detail.toString());
        model.addAttribute("bDto", detail);
        model.addAttribute("file", file);
        return "board/auctionDetail";


    }

    // 입찰하기
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/board/attend")
    public String attend(BoardDto bDto, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            bDto.setSb_id(userDetails.getUsername());
            log.info("======================" + bDto.toString());
            String result = bSer.attend(bDto);
            log.info("=================sadasdasdasdas=====" + result);
            if (result.equals("입찰 성공")) {
                bSer.auctionUser(bDto);
                BoardDto detail = bSer.auctionDetail(bDto);
                List<BoardFileDto> file = bSer.getFile(bDto);
                if (detail != null) {
                    model.addAttribute("bDto", detail);
                    model.addAttribute("file", file);
                    model.addAttribute("successMsg", result);
                    return "board/auctionDetail";
                }
            }else {
                BoardDto detail = bSer.auctionDetail(bDto);
                List<BoardFileDto> file = bSer.getFile(bDto);
                model.addAttribute("bDto", detail);
                model.addAttribute("file", file);
                model.addAttribute("successMsg", result);
                return "board/auctionDetail";
            }
        }
        return "redirect:/member/login";
    }

    // 경매 게시글 삭제
    @GetMapping("/board/auctionDelete")
    public String auctionDelete(@RequestParam("sb_num") String sb_num, RedirectAttributes redirectAttributes) {
        boolean result = bSer.saleBoardDelete(sb_num);
        if (result) {
            redirectAttributes.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
            return "redirect:/board/auctionList";
        }
        return "redirect:/board/auctionList";
    }

    // 중고거래 게시글 삭제
    @GetMapping("/board/marketDelete")
    public String marketDelete(@RequestParam("sb_num") String sb_num, RedirectAttributes redirectAttributes) {
        boolean result = bSer.saleBoardDelete(sb_num);
        if (result) {
            redirectAttributes.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
            return "redirect:/board/marketList";
        }
        return "redirect:/board/marketList";
    }

    // 공지사항으로
    @GetMapping("/board/noticeBoard")
    public String noticeBoard() {
        return "board/noticeBoard";
    }

    // 나의 거래로
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/myTrade")
    public String myTrade(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String name = userDetails.getUsername();
            log.info("--=-=-=-=-=아이디-=-=-=-=-={}",name);
            List<BoardDto> myAuction = bSer.myTrade(name);
            List<BoardDto> mySales = bSer.mySales(name);

            log.info("--=-=-=-=-=-=-=-=-=-={}",myAuction);

            if (myAuction!=null){
                model.addAttribute("myTrade", myAuction);
                if (mySales!=null){
                    model.addAttribute("mySales", mySales);
                }
            }
            return "member/myTrade";
        }
        return "redirect:/";
    }

    //중고거래 리스트
    @GetMapping("/board/marketList")
    public String marketList(BoardDto bDto, Model model) {
        int totalItems = bSer.countMarketItems(bDto);
        int totalPages = (int) Math.ceil((double) totalItems / BoardService.LISTCNT);

        if ( bDto.getPageNum()==null || bDto.getPageNum() < 1) {
           bDto.setPageNum(1);
        } else if (bDto.getPageNum() > totalPages) {
            bDto.setPageNum(totalPages);
        }

        int currentGroup = (bDto.getPageNum()- 1) / BoardService.PAGECOUNT;
        int startPage = currentGroup * BoardService.PAGECOUNT + 1;
        int endPage = Math.min(startPage + BoardService.PAGECOUNT - 1, totalPages);



        List<String> cateList = bSer.cateList();
        model.addAttribute("cateList", cateList);
        List<BoardDto> bList = bSer.getMarketList(bDto);
        log.info("========-=-=-=-=-=-=-=-=-=-=============" + bList.toString());
        if (!bList.isEmpty()) {
            model.addAttribute("bList", bList);
            model.addAttribute("currentPage", bDto.getPageNum());
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("pageCount", BoardService.PAGECOUNT);
        }
        return "board/marketList";

    }

    // 중고거래 물품 올리기 페이지
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/board/marketRegister")
    public String maketProductRegister(Model model) {
        List<String> cateList = bSer.cateList();
        model.addAttribute("cateList", cateList);

        return "board/marketRegister";
    }

    // 중고거래 물품 등록
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/board/marketProductRegister")
    public String marketProductRegister(BoardDto bDto, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            bDto.setSb_id(userDetails.getUsername());
            log.info("======================" + bDto.toString());
            boolean result = bSer.marketProductRegister(bDto, session);
            if (result) {
                return "redirect:/board/marketList";
            }
            return "redirect:/board/marketProductRegister";
        }

        return "redirect:/member/login";
    }

    // 중고거래 상세 페이지
    @GetMapping("/board/marketDetail")
    public String marketDetail(BoardDto bDto,Model model) {
        BoardDto detail = bSer.auctionDetail(bDto);
        List<BoardFileDto> file = bSer.getFile(bDto);
        log.info("=========auctionDetail============" + file.toString());
        log.info("==========auctionDetail============" + detail.toString());
        model.addAttribute("bDto", detail);
        model.addAttribute("file", file);
        return "board/marketDetail";


    }

    // 관심상품목록
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/myCart")
    public String myCart(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            List<BoardDto> myAuctionCart = bSer.myAuctionCart(userDetails.getUsername());
            List<BoardDto> mySalesCart = bSer.mySalesCart(userDetails.getUsername());
            model.addAttribute("myAuctionCart", myAuctionCart);
            model.addAttribute("mySalesCart",mySalesCart);

            return "member/myCart";
        }
        return "redirect:/member/login";
    }

    // 경매 관심상품 등록
    @GetMapping("/board/myAuctionCart")
    public String myAuctionCart(@RequestParam("sb_num") String sb_num,Model model,BoardDto bDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            List<BoardDto> myCart = bSer.myAuctionCart(userDetails.getUsername());

            bDto.setSb_num(sb_num);
            BoardDto detail = bSer.auctionDetail(bDto);
            List<BoardFileDto> file = bSer.getFile(bDto);
            for(BoardDto dto : myCart) {

                if(dto.getSb_num().equals(sb_num)){
                    model.addAttribute("msg", "이미 장바구니에 있는 상품입니다.");
                    model.addAttribute("bDto", detail);
                    model.addAttribute("file", file);
                    return "board/auctionDetail";
                }
            }
            boolean cart = bSer.myCartAttend(sb_num,userDetails.getUsername());
            if(cart){
                model.addAttribute("msg", "상품을 장바구니에 담았습니다..");
                model.addAttribute("bDto", detail);
                model.addAttribute("file", file);
                return "board/auctionDetail";
            }
            return "board/auctionList";
        }
        return "redirect:/member/login";
    }

    // 중고거래 관심상품 등록
    @GetMapping("/board/mySalesCart")
    public String mySalesCart(@RequestParam("sb_num") String sb_num,Model model,BoardDto bDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            List<BoardDto> myCart = bSer.mySalesCart(userDetails.getUsername());
            bDto.setSb_num(sb_num);
            BoardDto detail = bSer.auctionDetail(bDto);
            List<BoardFileDto> file = bSer.getFile(bDto);
            for(BoardDto dto : myCart) {
                if(dto.getSb_num().equals(sb_num)){
                    log.info("---------dto------{}",dto.getSb_num());
                    log.info("---------dto------{}",sb_num);
                    model.addAttribute("bDto", detail);
                    model.addAttribute("file", file);
                    model.addAttribute("msg", "이미 장바구니에 있는 상품입니다.");
                    return "board/marketDetail";
                }
            }
            bSer.myCartAttend(sb_num,userDetails.getUsername());
            model.addAttribute("bDto", detail);
            model.addAttribute("file", file);
            model.addAttribute("msg", "상품을 장바구니에 담았습니다..");
            return "board/marketDetail";
        }
        return "redirect:/member/login";
    }

    // 전체리스트 (검색 시)
    @GetMapping("/board/allList")
    public String allList(SearchDto sDto, Model model ) {
        int totalItems = bSer.countAllItems(sDto);
        int totalPages = (int) Math.ceil((double) totalItems / BoardService.LISTCNT);

        if (sDto.getPageNum()< 1) {
            sDto.setPageNum(1);
        } else if (sDto.getPageNum() > totalPages) {
            sDto.setPageNum(totalPages);
        }

        int currentGroup = (sDto.getPageNum() - 1) / BoardService.PAGECOUNT;
        int startPage = currentGroup * BoardService.PAGECOUNT + 1;
        int endPage = Math.min(startPage + BoardService.PAGECOUNT - 1, totalPages);
        List<BoardDto> bList = bSer.allList(sDto);
        model.addAttribute("bList",bList);
        model.addAttribute("currentPage", sDto.getPageNum());
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("pageCount", BoardService.PAGECOUNT);
        return "board/allList";
    }



}
