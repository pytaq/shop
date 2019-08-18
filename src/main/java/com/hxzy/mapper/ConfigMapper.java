package com.hxzy.mapper;

import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.entity.Config;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConfigMapper extends BaseMapper<Config> {

    /**
     * 删除再新增
     * @return
     */
    int delete();
    /**
     * 只有一个对象
     * @return
     */
    Config find();
}
