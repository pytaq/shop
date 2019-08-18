package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.User;
import com.hxzy.vo.SysRoleUserSearch;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

public interface UserMapper extends BaseMapper<User> {
    /**
     * 判断用户名称是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    int existsValue(User user);

    /**
     * 查询拥有该角色的用户
     * @param roleId
     * @return
     */
    List<User> findOwnUser(int roleId);

    /**
     * 查询没有拥有该角色的用户
     * @param roleId
     * @return
     */
    List<User> findNoOwnUser(int roleId);

    /**
     * 移出该角色拥有的用户ID
     * @param userId
     * @param roleId
     * @return
     */
    int deleteOwnUserId(@Param("userId") int userId,@Param("roleId") int roleId);

    /**
     * 添加该角色拥有的ID
     * @param userId
     * @param roleId
     * @return
     */
    int insertOwnUserId(@Param("userId") int userId,@Param("roleId") int roleId);

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
