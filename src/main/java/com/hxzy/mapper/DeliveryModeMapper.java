package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.DeliveryMode;
import com.hxzy.entity.ShopCategory;

public interface DeliveryModeMapper extends BaseMapper<DeliveryMode> {


    /**
     * 判断用户名称是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    int existsValue(DeliveryMode deliveryMode);

    /**
     * 删除
     * @param id
     * @return
     */
    int delete(int id);
}
