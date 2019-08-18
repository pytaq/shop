package com.hxzy.service;

import com.hxzy.common.service.BaseService;
import com.hxzy.entity.Config;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConfigService extends BaseService<Config> {

    /**
     * 显示对象
     * @return
     */
    Config find();

    /**
     * 删除配置再新增
     * @param config
     * @return
     */

    boolean save(Config config);
}
