package com.icia.seong.dao;

import com.icia.seong.dto.InventoryDto;
import com.icia.seong.dto.InventoryFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface InventoryDao {

    @Select("select * from h_product")
    List<InventoryDto> compareQuary();

    boolean addItemSelectKey(InventoryDto inventory);

    List<InventoryDto> getInventoryList();

    boolean fileInsertMap(Map<String, String> fMap);

    @Select("select h_p_sysfilename from h_p_image where h_p_pnum=#{h_p_num}")
    String[] getsysFiles(int h_p_num);

}
