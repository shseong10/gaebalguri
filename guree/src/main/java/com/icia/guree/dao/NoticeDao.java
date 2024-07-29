package com.icia.guree.dao;

import com.icia.guree.entity.NoticeDto;
import com.icia.guree.entity.SearchDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeDao {

    List<NoticeDto> getNoticeList(SearchDto sDto);

    boolean fileUpload(Map<String, String> fMap);

    int getNoticeCount(SearchDto sDto);

    boolean noticeWrite(NoticeDto nDto);

    NoticeDto getNoticeDetail(Integer n_num);

    boolean noticeUpdate(NoticeDto nDto);

    String[] getSysFiles(int n_num);

    void fileDelete(int n_num);

    String getNoticeViewId(String username, Integer n_num);

    void setNoticeViewInfo(Integer n_num, String username);

    void setNoticeView(Integer n_num);

    List<NoticeDto> getReportList(SearchDto sDto);

    int getReportCount(SearchDto sDto);
}
