package com.hxzy.common.service;

import com.hxzy.vo.PageData;
import com.hxzy.vo.PageSearch;

import java.util.List;

public interface BaseService<T> {
    boolean insert(T obj);

    boolean update(T obj);

    boolean updateSelective(T obj);

    T  findOne(int id);
    /**
     * 分页查询数据
     * @param pageSearch
     * @return List
     */
    PageData<T> searchPaging(PageSearch pageSearch);

    List<T> findAll();
}
