package com.hxzy.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

//数据库列的查询
@Data
public class DbColumn implements Serializable{
    private String columnName;
    private String ordinalPosition;
    private String isNullable;
    private String dataType;
    private String characterMaximumLength;
    private String columnType;
    private String columnKey;
    private String columnComment;

}
