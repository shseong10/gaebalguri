package com.icia.seong.dao;

import com.icia.seong.dto.CartDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartDao {

    boolean takeItemSelectKey(CartDto cart);
}
