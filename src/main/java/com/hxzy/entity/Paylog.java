package com.hxzy.entity;

import lombok.Data;

@Data
public class Paylog {
    private Integer id;

    /**
     * 支付方式
     */
    private String paytype;

    /**
     * 支付金额
     */
    private String paymaney;

    /**
     * 支付类型
     */
    private String ptype;

    /**
     * 支付方式
     */
    private String typename;

    private Integer pId;
}
