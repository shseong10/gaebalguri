package com.icia.guree.dao;

import com.icia.guree.entity.OrderDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderDao {

    boolean buyItemSelectKey(OrderDto order);
}
