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
public class OrderDto {
    private int h_order_num;
    private int h_o_p_num;
    private String h_o_user_id;
    private int h_o_qty;
    private int h_o_sales_price;
    private int h_o_total_price;
    private LocalDateTime h_o_date;
    private String h_o_status;
}
