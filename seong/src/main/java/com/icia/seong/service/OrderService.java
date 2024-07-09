package com.icia.seong.service;

import com.icia.seong.dao.OrderDao;
import com.icia.seong.dto.OrderDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class OrderService {
    @Autowired
    private OrderDao oDao;

    public boolean buyItem(OrderDto order, HttpSession session) {
        boolean result = oDao.buyItemSelectKey(order);
        if (result) {
            return true;
        } else {
            return false;
        }
    }
}
