package com.icia.guree.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDto {
    private String m_id;
    private String m_pw;
    private String m_name;
    private String m_phone;
    private String m_addr;
    private int m_point;
    private int m_sumPoint;
    private String m_companyNum;
    private String m_role;
}
