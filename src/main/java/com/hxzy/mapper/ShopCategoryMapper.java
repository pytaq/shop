package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.ShopCategory;
import com.hxzy.service.ShopCategoryService;

import java.util.List;

public interface ShopCategoryMapper extends BaseMapper<ShopCategory> {


    /**
     * 判断用户名称是否存在
     * @param
     * @return  大于0已存在， 不能使用
     */
    int existsValue(ShopCategory shopCategory);


    /**
     * 根据parentId查询数据
     * @param pid
     * @return
     */
    List<ShopCategory>  searchByParentId(int pid);

}
