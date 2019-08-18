package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;


/**
 * sys_role
 * @author 
 */
@Data
public class SysRole implements Serializable {
    private Integer id;

    /**
     * 权限名称
     */
    private String rolename;

    /**
     * 唯一权限标识
     */
    private String authority;

    /**
     * 1启用，0禁用
     */
    private Integer state;
}