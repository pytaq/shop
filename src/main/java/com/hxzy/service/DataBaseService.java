package com.hxzy.service;

import java.util.List;

public interface DataBaseService {


    /**
     * 根据数据库名称查询表名
     * @param dbName
     * @return
     */
    List<String> findAllTableNames(String dbName);

    /**
     * 根据数据库名称和表名得表结构
     * @param dbName
     * @param tableName
     * @return
     */
    String findTableDesc(String dbName,String tableName);

}
