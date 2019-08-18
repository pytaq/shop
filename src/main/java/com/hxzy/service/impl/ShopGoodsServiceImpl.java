package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.ShopGoods;
import com.hxzy.mapper.ShopGoodsMapper;
import com.hxzy.service.ShopGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ShopGoodsServiceImpl extends BaseServiceImpl<ShopGoods> implements ShopGoodsService {

    private ShopGoodsMapper shopGoodsMapper;


    @Autowired
    public void setShopGoodsMapper(ShopGoodsMapper shopGoodsMapper) {
        this.shopGoodsMapper = shopGoodsMapper;
        super.setBaseMapper(shopGoodsMapper);
    }

    public boolean existsValue(ShopGoods shopGoods) {
        return  this.shopGoodsMapper.existsValue(shopGoods)>0;
    }

    @Override
    public boolean insertSelective(ShopGoods shopGoods) {
        return  this.shopGoodsMapper.insertSelective(shopGoods)>0;
    }
}


