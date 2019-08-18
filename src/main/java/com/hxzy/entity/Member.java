package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * member
 * @author 
 */

@Data
public class Member implements Serializable {
    private String openid;

    private String email;

    /**
     * 积分
     */
    private Integer credit;

    /**
     * 余额
     */
    private Double gold;

    private String realname;

    private String mobile;

    private String pwd;

    private Integer createtime;

    /**
     * 是否为临时账户 1是，0为否
     */
    private Boolean istemplate;

    /**
     * 0为禁用，1为可用
     */
    private Boolean status;

    /**
     * 账户经验值
     */
    private Integer experience;

    /**
     * 用户头像
     */
    private String avatar;

    /**
     * 已提取余额
     */
    private Double outgold;

    /**
     * 提款信息 序列化
     */
    private String outgoldinfo;

    /**
     * 微信openid
     */
    private String weixinOpenid;

    /**
     * 微信详情
     */
    private Wxfans wxfans;

    /**
     * 阿里openid
     */
    private String alipayOpenid;
}