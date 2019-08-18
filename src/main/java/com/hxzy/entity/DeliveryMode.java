package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * delivery_mode
 *
 * @author
 */
@Data
public class DeliveryMode implements Serializable {
    /**
     * 编号
     */
    private Integer id;

    /**
     * 配送说明
     */
    private String deliveryexplain;

    /**
     * 配送小费
     */
    private Double deliveryfee;




}