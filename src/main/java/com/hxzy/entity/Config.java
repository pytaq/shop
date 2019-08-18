package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * config
 * @author 
 */
@Data
public class Config implements Serializable {
    /**
     * 配置ID
     */
    private Integer id;

    /**
     * 商城名称
     */
    private String title;

    /**
     * 商城公司地址
     */
    private String address;

    /**
     * 浏览器标题
     */
    private String webtitle;

    /**
     * 商城邮箱
     */
    private String email;

    /**
     * 商城关键字
     */
    private String keyword;

    /**
     * 商城描述
     */
    private String description;

    /**
     * 商城电话
     */
    private String phone;

    /**
     * 备案号
     */
    private String icp;

    /**
     * 商城logo图
     */
    private String logo;

    /**
     * 商城第三方统计js代码
     */
    private String tongjicode;

    /**
     * 商城第三方客服代码
     */
    private String kfcode;


}