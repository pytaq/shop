package com.hxzy.service;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.service.BaseService;
import com.hxzy.entity.User;
import com.hxzy.vo.PageData;
import com.hxzy.vo.SysRoleUserSearch;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

public interface UserService extends BaseService<User> {
    /**
     * 判断用户名称是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    boolean existsValue(User user);

    /**
     * 查询拥有该角色的用户
     * @param search
     * @return
     */
    PageData<User> findOwnUser(SysRoleUserSearch search);

    /**
     * 查询没有拥有该角色的用户
     * @param search
     * @return
     */
    PageData<User> findNoOwnUser(SysRoleUserSearch search);

    /**
     * 移出该角色拥有的用户ID
     * @param userId
     * @param roleId
     * @return
     */
    boolean deleteOwnUserId(@Param("userId") int userId, @Param("roleId") int roleId);

    /**
     * 添加该角色拥有的ID
     * @param userId
     * @param roleId
     * @return
     */
    boolean insertOwnUserId(@Param("userId") int userId,@Param("roleId") int roleId);

    /**
     * 登录
     * @param userName
     * @return
     */
    User login(String userName);

    /**
     * 根据用户名查询它有角色权限
     * @param id
     * @return
     */
    Set<String> findUserOwnRoleAuthority(int id);

    /**
     * 根据用户角色拥有的权限
     * @param id
     * @return
     */
    Set<String> findUserOwnMenuAuthority(int id);
}
