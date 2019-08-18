package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.DeliveryMode;
import com.hxzy.mapper.DeliveryModeMapper;
import com.hxzy.service.DeliveryModeServlice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class DeliveryModeServliceImpl extends BaseServiceImpl<DeliveryMode> implements DeliveryModeServlice {


    private DeliveryModeMapper deliveryModeMapper;

    @Autowired
    public void setDeliveryModeMapper(DeliveryModeMapper deliveryModeMapper) {
        this.deliveryModeMapper = deliveryModeMapper;
        super.setBaseMapper(deliveryModeMapper);
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public boolean existsValue(DeliveryMode deliveryMode) {
        return this.deliveryModeMapper.existsValue(deliveryMode) > 0;
    }
    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean delete(int id) {
        return this.deliveryModeMapper.delete(id) > 0;
    }



}
