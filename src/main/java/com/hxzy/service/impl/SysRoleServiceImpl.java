package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.SysRole;
import com.hxzy.mapper.SysRoleMapper;
import com.hxzy.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements SysRoleService {

    private SysRoleMapper sysRoleMapper;

    @Autowired
    public void setSysRoleMapper(SysRoleMapper sysRoleMapper) {
        this.sysRoleMapper = sysRoleMapper;
        super.setBaseMapper(sysRoleMapper);
    }
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public boolean existsVaule(SysRole role) {
        return this.sysRoleMapper.existsValue(role)>0;
    }
}
