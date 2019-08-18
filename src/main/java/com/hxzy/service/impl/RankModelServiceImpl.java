package com.hxzy.service.impl;

import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.entity.RankModel;
import com.hxzy.mapper.RankModelMapper;
import com.hxzy.service.RankModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class RankModelServiceImpl extends BaseServiceImpl<RankModel> implements RankModelService {

    private RankModelMapper rankModelMapper;

    @Autowired
    public void setRankModelMapper(RankModelMapper rankModelMapper) {
        this.rankModelMapper = rankModelMapper;
        super.setBaseMapper(rankModelMapper);
    }
}
