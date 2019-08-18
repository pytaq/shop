package com.hxzy.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.ShopCategory;
import com.hxzy.mapper.ShopCategoryMapper;
import com.hxzy.service.ShopCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class ShopCategoryServiceImpl extends BaseServiceImpl<ShopCategory> implements ShopCategoryService {

    @Autowired
    private ShopCategoryMapper shopCategoryMapper;


    @Autowired
    public void setShopCategoryMapper(ShopCategoryMapper shopCategoryMapper) {
        this.shopCategoryMapper = shopCategoryMapper;

        super.setBaseMapper(shopCategoryMapper);
    }


    @Override
    public boolean existsValue(ShopCategory shopCategory) {
        return this.shopCategoryMapper.existsValue(shopCategory) > 0;
    }

    @Override
    public List<ShopCategory> searchByParentId(int pid) {
        return this.shopCategoryMapper.searchByParentId(pid);
    }
}
