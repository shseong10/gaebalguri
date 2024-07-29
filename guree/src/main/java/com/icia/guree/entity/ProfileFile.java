package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.web.multipart.MultipartFile;

@Data
@Accessors(chain = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProfileFile {
    private String m_id;
    private String m_name;
    private String m_addr;
    private String pf_oriFileName;
    private String pf_sysFileName;
    private String m_sumPoint;
    private String p_level;
    private MultipartFile attachment;



}
