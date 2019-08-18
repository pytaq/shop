package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.Config;
import com.hxzy.mapper.ConfigMapper;
import com.hxzy.service.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Transactional
@Service
public class ConfigServiceImpl extends BaseServiceImpl<Config> implements ConfigService {


    private ConfigMapper configMapper;

    @Autowired
    public void setConfigMapper(ConfigMapper configMapper) {
        this.configMapper = configMapper;
        super.setBaseMapper(configMapper);
    }


    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Config find() {
        return this.configMapper.find();
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean save(Config config) {
        this.configMapper.delete();
        int result = this.configMapper.insert(config);
        return result > 0;
    }
}
