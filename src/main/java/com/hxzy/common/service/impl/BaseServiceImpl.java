package com.hxzy.common.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.hxzy.common.mapper.BaseMapper;
import com.hxzy.common.service.BaseService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.PageSearch;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public abstract class BaseServiceImpl<T> implements BaseService<T> {

    protected Logger logger= LogManager.getLogger(this);

    private BaseMapper<T>  baseMapper;

    public void setBaseMapper(BaseMapper<T> baseMapper) {
        this.baseMapper = baseMapper;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean insert(T obj) {
        return this.baseMapper.insert(obj)>0;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean update(T obj) {
        return this.baseMapper.update(obj)>0;
    }


    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public T findOne(int id) {
        return  this.baseMapper.findOne(id);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean updateSelective(T obj) {
        return this.baseMapper.updateSelective(obj)>0;
    }
    /**
     * 分页查询
     * @param pageSearch
     * @return
     */
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public PageData<T> searchPaging(PageSearch pageSearch) {
        //分页
        PageHelper.offsetPage(pageSearch.getOffset(), pageSearch.getLimit());
        //查询数据
        List<T> search = this.baseMapper.search(pageSearch);

        PageData pageData=new PageData();

        //将查询数据转换为分页数据
        Page<T> page =(Page) search;
        //得到总记录数
        long total = page.getTotal();
        //返回值参数
        pageData.setRows(search);
        pageData.setTotal(total);

        return pageData;
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<T> findAll() {
        return this.baseMapper.findAll();
    }
}
