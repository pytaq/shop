package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;


@Data
public class ShopAddress implements Serializable {


    private Integer openid;

    private String address;

    /**
     * 是否默认
     */
    private boolean isdefault;


}
