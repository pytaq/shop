package com.hxzy.vo;

import lombok.Data;

/**
 * 自定义ztree菜单格式（简易版）
 */
@Data
public class MenuTreeVO {
    private int id;
    private int pId;  //上级编号(0代表根节点)
    private String menuName;  //菜单名称
    private boolean open;  //是否展开
    private boolean checked=false;  //是否选中

}
