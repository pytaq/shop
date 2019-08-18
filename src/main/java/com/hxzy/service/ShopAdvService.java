package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.ShopAdv;

public interface ShopAdvService extends BaseService<ShopAdv> {

    boolean delete(int id);
}
