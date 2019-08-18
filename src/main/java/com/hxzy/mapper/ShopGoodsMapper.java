package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.ShopGoods;

public interface ShopGoodsMapper  extends BaseMapper<ShopGoods> {
    int insertSelective(ShopGoods shopGoods);

    int existsValue(ShopGoods shopGoods);

}
