package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.SysRole;

public interface SysRoleService extends BaseService<SysRole> {

    /**
     * 判断角色是否存在
     * @param role
     * @return
     */
    boolean existsVaule(SysRole role);
}
