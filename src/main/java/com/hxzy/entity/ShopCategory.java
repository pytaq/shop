package com.hxzy.entity;


import lombok.Data;

import java.io.Serializable;

@Data
public class ShopCategory implements Serializable {


    /**
     * 分类
     */
    private Integer id;

    /**
     * 推荐该类商品所能获得的佣金
     */
    private Integer commission;

    /**
     * 分类名称
     */
    private String name;

    /**
     * 分类图片
     */
    private String thumb;

    /**
     * 分类广告图片
     */
    private String thumbadv;

    /**
     * 分类广告url
     */
    private String thumbadvurl;

    /**
     * 上级分类ID,0为第一级
     */
    private Integer parentid;

    /**
     * 推荐
     */
    private Integer isrecommand;

    /**
     * 分类介绍
     */
    private String description;

    /**
     * 排序
     */
    private Integer displayorder;

    /**
     * 是否删除
     */
    private Integer deleted;

    /**
     * 是否开启
     */
    private Integer enabled;

}
