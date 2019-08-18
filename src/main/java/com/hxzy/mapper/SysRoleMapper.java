package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.SysRole;

public interface SysRoleMapper extends BaseMapper<SysRole> {

    /**
     * 判断角色是否存在
     * @param role
     * @return
     */
    int existsValue(SysRole role);

}
