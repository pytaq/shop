package com.hxzy.entity;

import lombok.Data;

import javax.xml.soap.Text;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * shop_goods
 *
 * @author
 */

@Data
public class ShopGoods implements Serializable {


    /**
     * 编号
     */
    private Integer id;

    /**
     * 一级分类
     */
    private Integer pcate;

    /**
     * 请选择二级分类
     */
    private Integer ccate;

    /**
     * 0为实体，1为虚拟
     */
    private Integer type;

    /**
     * 是否上架销售
     */
    private Integer status;

    /**
     * 显示上架顺序
     */
    private Integer displayorder;

    /**
     * 标题
     */
    private String title;

    /**
     * 移除图片
     */
    private String thumb;

    /**
     * 商品简单描述
     */
    private String description;

    /**
     * 重量
     */
    private BigDecimal weight;

    /**
     * 商品条码
     */
    private String productsn;

    /**
     * 本店售价
     */
    private BigDecimal marketprice;

    /**
     * 市场售价
     */
    private BigDecimal productprice;

    /**
     * 库存
     */
    private Integer total;

    /**
     * 0 拍下减库存 1 付款减库存 2 永久不减
     */
    private Integer totalcnf;

    /**
     * 销售额
     */
    private Integer sales;

    /**
     * 创建时间
     */
    private Integer createtime;

    /**
     * 信用积分
     */
    private Integer credit;

    /**
     * 选择
     */
    private Integer hasoption;

    /**
     * 新品
     */
    private Integer isnew;

    /**
     * 免运费商品,打勾表示此商品不会产生运费花销，否则按照正常运费计算。
     */
    private Integer issendfree;

    /**
     * 热卖
     */
    private Integer ishot;

    /**
     * 打折
     */
    private Integer isdiscount;

    /**
     * 首页推荐
     */
    private Integer isrecommand;

    /**
     * 限时促销,1开启限时促销
     */
    private Integer istime;

    /**
     * 开启限时促销
     */
    private Integer timestart;

    /**
     * 关闭限时促销
     */
    private Integer timeend;

    /**
     * 浏览次数
     */
    private Integer viewcount;

    /**
     * 已删除
     */
    private Byte deleted;

    /**
     * 首发
     */
    private Integer isfirst;

    /**
     * 精品
     */
    private Integer isjingping;

    /**
     * 是否是核销产品0否1是
     */
    private Integer isverify;


    /**
     * 奖励积分,会员购买商品赠送的积分, 如果不填写，则默认为不奖励积分
     */
    private String remark;


    /**
     * 商品详细描述
     */
    private String content;

    private  String goodssn;


}