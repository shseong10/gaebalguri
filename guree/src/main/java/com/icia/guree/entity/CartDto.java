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
public class CartDto {
    private int h_cart_num;
    private int h_c_p_num;
    private String h_c_user_id;
    private int h_c_p_qty;
    private int h_c_p_sales_price;
    private int h_c_p_total_price;
}
