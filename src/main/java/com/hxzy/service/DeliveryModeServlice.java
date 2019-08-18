package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.DeliveryMode;

public interface DeliveryModeServlice extends BaseService<DeliveryMode> {


    /**
     * 判断用户名称是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    boolean existsValue(DeliveryMode deliveryMode);

    /**
     * 判断删除
     * @param id
     * @return
     */
    boolean delete(int id);
}
