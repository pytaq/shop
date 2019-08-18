package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.Paylog;

public interface PaylogService extends BaseService<Paylog> {

    /**
     * 判断支付方式是否存在
     * @param
     * @return
     */
    boolean existsValue(Paylog paylog);
}
