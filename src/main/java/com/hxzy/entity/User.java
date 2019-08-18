package com.hxzy.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.io.Serializable;

/**
 * user
 * @author
 */
@Data
public class User implements Serializable {
    private Integer id;

    /**
     * 创建时间
     */
    private Integer createtime;

    /**
     * 密码
     */
    @JSONField(serialize=false)
    private String password;

    /**
     * 用户名
     */
    private String username;
    /**
     * 盐
     */
    @JSONField(serialize=false)
    private String salt;

    private static final long serialVersionUID = 1L;


}