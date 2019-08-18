package com.hxzy.mapper;

import com.hxzy.entity.DbColumn;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 数据库查询的查询
 */
public interface DataBaseMapper {

    /**
     * 根据数据库名称查询表名
     * @param dbName
     * @return
     */
    List<String> findAllTableNames(String dbName);

    List<DbColumn> findTableDesc(@Param("dbName") String dbName, @Param("tableName")String tableName);
}
