package com.icia.guree.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

@Mapper
public interface FileDao {

    @Insert("insert into profile values(#{m_id},#{oriFileName},#{sysFileName})")
    boolean profilefileInsertMap(Map<String, String> fMap);

    @Insert("insert into boardfile values(null,#{bf_sb_num},#{oriFileName},#{sysFileName})")
    boolean boardfileInsertMap(Map<String, String> fMap);

    @Delete("delete from profile where m_id =#{m_id} ")
    boolean profileDelete(String m_id);

    @Select("select pf_sysfilename from profile where m_id = #{m_id}")
    String[] getSysFiles(String m_id);

    @Select("select bf_sysfilename from boardfile where bf_sb_num = #{sb_num}")
    String[] getBoardSysFiles(Integer sb_num);
}
