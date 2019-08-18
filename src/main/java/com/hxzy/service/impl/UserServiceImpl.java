package com.hxzy.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.common.util.DateUtil;
import com.hxzy.common.util.MD5Utils;
import com.hxzy.entity.User;
import com.hxzy.mapper.UserMapper;
import com.hxzy.service.UserService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.SysRoleUserSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Transactional
@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService {

    private UserMapper userMapper;

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
        super.setBaseMapper(userMapper);
    }

    @Override
    public boolean existsValue(User user) {
        return this.userMapper.existsValue(user)>0;
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public PageData<User> findOwnUser(SysRoleUserSearch search) {
        //开启分页
        PageHelper.offsetPage(search.getOffset(),search.getLimit());
        List<User> arrUser=this.userMapper.findOwnUser(search.getRoleId());

        //强转
        Page<User>  pg=(Page<User>)arrUser;

        //返回
        PageData<User>  pageData=new PageData<User>();
        pageData.setRows(arrUser);
        pageData.setTotal(pg.getTotal());

        return pageData;
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public PageData<User> findNoOwnUser(SysRoleUserSearch search) {
        //开启分页
        PageHelper.offsetPage(search.getOffset(),search.getLimit());
        List<User> arrUser=this.userMapper.findNoOwnUser(search.getRoleId());

        //强转
        Page<User>  pg=(Page<User>)arrUser;

        //返回
        PageData<User>  pageData=new PageData<User>();
        pageData.setRows(arrUser);
        pageData.setTotal(pg.getTotal());

        return pageData;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean deleteOwnUserId(int userId, int roleId) {
         this.userMapper.deleteOwnUserId(userId,roleId);
        return true;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean insertOwnUserId(int userId, int roleId) {
        int i=this.userMapper.insertOwnUserId(userId,roleId);
        return i>0;
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public User login(String userName) {
        return this.userMapper.login(userName);
    }

    //根据用户名查询它有角色权限
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Set<String> findUserOwnRoleAuthority(int id) {
        return this.userMapper.findUserOwnRoleAuthority(id);
    }

    // 根据用户角色拥有的权限
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Set<String> findUserOwnMenuAuthority(int id) {
        return this.userMapper.findUserOwnMenuAuthority(id);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean insert(User obj) {
        String salt= MD5Utils.randomSalt(5);
        System.out.println(salt);
        obj.setCreatetime(DateUtil.dateToInt(new Date()));
        String password = MD5Utils.MD5Encode(obj.getPassword(),salt);
        obj.setPassword(password);
        return super.insert(obj);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean updateSelective(User obj) {
        String salt= MD5Utils.randomSalt(5);
        System.out.println(salt);
        String password = MD5Utils.MD5Encode(obj.getPassword(),salt);
        obj.setSalt(salt);
        obj.setPassword(password);
        return super.updateSelective(obj);
    }


}
