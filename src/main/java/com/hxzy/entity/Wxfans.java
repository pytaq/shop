package com.hxzy.entity;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * weixin_wxfans
 * @author 
 */
public class Wxfans implements Serializable {
    /**
     * 微信身份授权认证
     */
    private String weixin_openid;

    /**
     * 创建时间
     */
    private Integer createtime;

    /**
     * 身份认证
     */
    private String openid;

    /**
     * 是否订阅
     */
    private Boolean follow;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 性别(0:保密 1:男 2:女)
     */
    private Boolean gender;

    /**
     * 地理位置经度
     */
    private BigDecimal longitude;

    /**
     * 地理位置纬度
     */
    private BigDecimal latitude;

    /**
     * 地理位置精度
     */
    private BigDecimal precision;

    private static final long serialVersionUID = 1L;

    public String getWeixin_openid() {
        return weixin_openid;
    }

    public void setWeixin_openid(String weixin_openid) {
        this.weixin_openid = weixin_openid;
    }

    public Integer getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Integer createtime) {
        this.createtime = createtime;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public Boolean getFollow() {
        return follow;
    }

    public void setFollow(Boolean follow) {
        this.follow = follow;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }

    public BigDecimal getPrecision() {
        return precision;
    }

    public void setPrecision(BigDecimal precision) {
        this.precision = precision;
    }
}