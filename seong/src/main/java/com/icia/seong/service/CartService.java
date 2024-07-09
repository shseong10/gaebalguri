package com.icia.seong.service;

import com.icia.seong.dao.CartDao;
import com.icia.seong.dao.OrderDao;
import com.icia.seong.dto.CartDto;
import com.icia.seong.dto.OrderDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class CartService {
    @Autowired
    private CartDao cDao;

    public boolean takeItem(CartDto cart, HttpSession session) {
        boolean result = cDao.takeItemSelectKey(cart);
        if (result) {
            return true;
        } else {
            return false;
        }
    }
}
