package com.hxzy.vo;

import lombok.Data;

import java.util.List;

/**
 * 自定义左边登录后显示的菜单列表
 */
@Data
public class MenuNavVO {
    private Integer id;
    private String menuName;
    private String actionName;
    private String authority;
    private Integer parentId;
    //子节点
    private List<MenuNavVO> children;

}
