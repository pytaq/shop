package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.ShopAdv;
import com.hxzy.mapper.ShopAdvMapper;
import com.hxzy.service.ShopAdvService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class ShopAdvServiceImpl extends BaseServiceImpl<ShopAdv> implements ShopAdvService {

    @Autowired
    private ShopAdvMapper shopAdvMapper;

    @Autowired
    public void setShopAdvMapper(ShopAdvMapper shopAdvMapper) {
        this.shopAdvMapper = shopAdvMapper;

        super.setBaseMapper(shopAdvMapper);
    }

    @Override
    public boolean delete(int id) {
        return this.shopAdvMapper.delete(id) > 0;
    }
}
