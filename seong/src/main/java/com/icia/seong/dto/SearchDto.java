package com.icia.seong.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SearchDto {
//    private String colName;
    private String keyword;
    private Integer pageNum;
    private Integer listCnt;  //10, 페이지당 글의갯수
    private Integer startIdx; //1page: 0~   2page:10~
}
