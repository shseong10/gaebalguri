package com.icia.seong.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Accessors(chain = true)
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InventoryDto {
    private int h_p_num;
    private String h_p_category;
    private String h_p_name;
    private int h_p_price;
    private int h_p_quantity;
    private String h_p_desc;
    private LocalDateTime h_p_date;

    List<MultipartFile> attachments;

    private List<InventoryFile> ifList;
}
