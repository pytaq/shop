package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * shop_adv
 *
 * @author
 */

@Data
public class ShopAdv implements Serializable {
    /**
     * id
     */
    private Integer id;

    /**
     * 跳转连接
     */
    private String link;

    /**
     * 图片内容
     */
    private String thumb;

    /**
     * 显示顺序
     */
    private Integer displayorder;

    /**
     * 是否启用
     */
    private Integer enabled;

}