package com.icia.guree.dao;

import com.icia.guree.entity.CartDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartDao {

    boolean takeItemSelectKey(CartDto cart);
}
