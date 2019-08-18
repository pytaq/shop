package com.hxzy.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * sys_menu
 * @author
 */
@Data
public class SysMenu  implements Serializable{
    private Integer id;
    private String menuName;
    private Integer menuLevel;
    private String actionName;
    private String authority;
    private Integer sort;
    private Integer display;
    private Integer parentId;
    private String parentLevel;
}