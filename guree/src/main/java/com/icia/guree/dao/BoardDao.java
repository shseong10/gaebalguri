package com.icia.guree.dao;

import com.icia.guree.entity.BoardDto;
import com.icia.guree.entity.BoardFileDto;
import com.icia.guree.entity.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardDao {

    boolean productRegister(BoardDto bDto);

    List<BoardDto> auctionList(BoardDto bDto);

    BoardDto auctionDetail(BoardDto bDto);

    void attend(BoardDto bDto);

    void auctionUser(BoardDto bDto);

    boolean saleBoardDelete(String sb_num);

    String getNumber();

    List<BoardFileDto> getFile(BoardDto bDto);

    String getAttender(BoardDto bDto);

    int countAuctionItems(BoardDto bDto);

    List<BoardDto> getMyTrade(String name);

    List<BoardDto> getMarketList(BoardDto bDto);

    boolean marketProductRegister(BoardDto bDto);

    List<BoardDto> getMySales(String name);

    List<BoardDto> getMyCart(String username);

    List<BoardDto> getMySalesCart(String username);

    boolean myCartAttend(String sb_num, String username);

    List<BoardDto> allList(SearchDto sDto);

    String getViewId(String username, String sb_num);

    void setBoardView(String sb_num);

    void setViewInfo(String sb_num, String username);

    List<BoardDto> getRecItem();

    List<BoardFileDto> getIndexFile();

    List<BoardDto> boardDelList();

    List<BoardDto> marketBoardDelList();

    void realDelete(Integer sb_num);

    void restore(Integer sb_num);

    List<String> getCateList();

    void cateDelete(String c_kind);

    void cateAttend(String c_kind);

    int countMarketItems(BoardDto bDto);

    int countAllItems(SearchDto sDto);

    void auctionEnd(BoardDto bDto);

    List<BoardDto> boardEndList();
}
