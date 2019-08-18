package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.ShopGoods;

import java.util.stream.BaseStream;

public interface ShopGoodsService extends BaseService<ShopGoods> {
    boolean insertSelective(ShopGoods shopGoods);
    boolean  existsValue(ShopGoods shopGoods);
}
