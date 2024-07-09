package com.icia.seong.dao;

import com.icia.seong.dto.InventoryDto;
import com.icia.seong.dto.OrderDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderDao {

    boolean buyItemSelectKey(OrderDto order);
}
