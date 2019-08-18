package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.Paylog;
import com.hxzy.entity.SysRole;
import com.hxzy.mapper.PaylogMapper;
import com.hxzy.mapper.SysRoleMapper;
import com.hxzy.service.PaylogService;
import com.hxzy.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PaylogServiceImpl extends BaseServiceImpl<Paylog> implements PaylogService {

    private PaylogMapper paylogMapper;

    @Autowired
    public void setPaylogMapper(PaylogMapper paylogMapper){
        this.paylogMapper= paylogMapper;
        super.setBaseMapper(paylogMapper);
    }


    @Override
    public boolean existsValue(Paylog paylog) {
        return this.paylogMapper.existsValue(paylog) > 0;
    }
}
