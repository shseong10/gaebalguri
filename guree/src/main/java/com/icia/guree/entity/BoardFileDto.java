package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardFileDto {
    private String bf_num;
    private String bf_sb_num;
    private String bf_oriFileName;
    private String bf_sysFileName;
}
