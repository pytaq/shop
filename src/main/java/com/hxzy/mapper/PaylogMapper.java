package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.Paylog;

public interface PaylogMapper extends BaseMapper {

    /**
     * 判断支付方式是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    int existsValue(Paylog paylog);
}
