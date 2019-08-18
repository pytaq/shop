package com.hxzy.service;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.service.BaseService;
import com.hxzy.entity.SysMenu;
import com.hxzy.entity.User;
import com.hxzy.vo.MenuNavVO;
import com.hxzy.vo.MenuTreeVO;

import java.util.List;

public interface SysMenuService  extends BaseService<SysMenu> {

    /**
     * 判断用户名称是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    boolean existsValue(SysMenu sysMenu);

    /**
     * 根据名称查询
     * @param SysMenu
     * @return
     */
    List<SysMenu> search(SysMenu SysMenu);


    /**
     * 验证方法
     * @param sysMenu
     * @return
     */
    Boolean exist(SysMenu sysMenu);

    /**
     * 得到某个角色拥有的菜单权限
     * @param roleId
     * @return
     */
    List<MenuTreeVO> findRoleOwnMenu(Integer roleId);

    /**
     * 保存角色菜单权限
     * @param roleId
     * @param authority
     * @return
     */
    boolean saveAuthority(int roleId, String authority);

    /**
     * 查询该用户拥有的权限菜单
     * @param userId
     * @return
     */
    List<MenuNavVO> searchUserOwnMenu(int userId);

}
