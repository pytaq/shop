package com.hxzy.service;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.service.BaseService;
import com.hxzy.entity.ShopCategory;

import java.util.List;

public interface ShopCategoryService  extends BaseService<ShopCategory>{


    /**
     * 判断用户名称是否存在
     * @param
     * @return
     */
    boolean existsValue(ShopCategory shopCategory );

    /**
     * 根据父级编号查询
     * @param pid
     * @return
     */
    List<ShopCategory> searchByParentId(int pid);


}
