package com.icia.guree.entity;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
public class NoticeDto {
    private int n_num;
    private String n_id;
    private String n_kind;
    private String n_title;
    private String n_contents;

    private String n_date;
    private int n_views;
    List<MultipartFile> attachments;
    private List<NoticeFileDto> nfList;
}
