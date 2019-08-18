package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.SysMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysMenuMapper  extends BaseMapper<SysMenu> {

    int existsValue(SysMenu sysMenu);

    /**
     * 根据名称查询
     * @param SysMenu
     * @return
     */
    List<SysMenu> search(SysMenu SysMenu);

    /**
     * 查询某个角色拥有菜单ID
     * @param roleId
     * @return
     */
    List<Integer> findOwnMenuId(Integer roleId);

    //删除角色拥有菜单
    int deleteAllRoleAuthority(int roleId);

    //批量新增
    int saveAuthority(@Param("roleId") int roleId, @Param("arrMenuIds") List<Integer> arrMenuIds);

    /**
     * 查询该用户拥有的权限菜单
     * @param userId
     * @return
     */
    List<SysMenu> searchUserOwnMenu(int userId);
}
