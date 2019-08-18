package com.hxzy.common.mapper;

import com.hxzy.vo.PageSearch;

import java.util.List;

public interface BaseMapper<T> {
     int insert(T obj);

     int update(T obj);

     int updateSelective(T obj);


     T  findOne(int id);

     /**
      * 分页查询数据
      * @param pageSearch
      * @return List
      */
     List<T> search(PageSearch pageSearch);

     List<T> findAll();

}
