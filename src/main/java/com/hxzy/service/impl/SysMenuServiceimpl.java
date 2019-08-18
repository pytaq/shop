package com.hxzy.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.service.impl.BaseServiceImpl;
import com.hxzy.common.util.JedisUtil;
import com.hxzy.entity.SysMenu;
import com.hxzy.mapper.SysMenuMapper;
import com.hxzy.service.SysMenuService;
import com.hxzy.vo.MenuNavVO;
import com.hxzy.vo.MenuTreeVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;

@Service
@Transactional
public class SysMenuServiceimpl extends BaseServiceImpl<SysMenu> implements SysMenuService {

    //菜单redis的前缀名称
    @Value("${leftmenu.redisKey}")
    private String leftMenuRedisKeyPriex;

    //redis过期时间
    @Value("${leftmenu.redisKey.timeout}")
    private int timeout=1800;

    //redis
    @Autowired
    private JedisUtil  jedisUtil;


    private SysMenuMapper sysMenuMapper;

    @Autowired
    public void setSysMenuMapper(SysMenuMapper sysMenuMapper) {
        this.sysMenuMapper = sysMenuMapper;

        super.setBaseMapper(sysMenuMapper);
    }
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public boolean existsValue(SysMenu sysMenu) {
        return this.sysMenuMapper.existsValue(sysMenu) > 0;
    }
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<SysMenu> search(SysMenu sysMenu) {
        return this.sysMenuMapper.search(sysMenu);
    }



    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean insert(SysMenu sysMenu){
        //后期修改
        sysMenu.setSort(0);
        //设置parentLevel
        StringBuffer stringBuffer = new StringBuffer();
        //递归调用
        parentLevel(stringBuffer, sysMenu.getParentId(), sysMenu.getMenuLevel());
        stringBuffer.append(sysMenu.getParentId());
        String str = stringBuffer.toString();
        System.out.println("拼接截取后的 parentLevel" + str);
        sysMenu.setParentLevel(str);
        System.out.println("赋值后" + sysMenu.toString());
        return super.insert(sysMenu);//调后台业务逻辑
    }

    //验证方法
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Boolean exist(SysMenu sysMenu) {
        System.out.println("sysMenu："+sysMenu);
        boolean valid=false;
        //验证用户名和父级id
        //修改
        if(null!=sysMenu.getId()&&sysMenu.getId()>0){
            SysMenu one = this.findOne(sysMenu.getId());
            if(!one.getMenuName().equals(sysMenu.getMenuName())){
                valid = this.existsValue(sysMenu);
            }
        }else{
            //新增验证
            valid=this.existsValue(sysMenu);
        }
        return !valid;
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<MenuTreeVO> findRoleOwnMenu(Integer roleId) {
        List<MenuTreeVO>  allMenuTreeVo=new ArrayList<MenuTreeVO>();

        //查询所有的菜单
         List<SysMenu> allMenu=this.sysMenuMapper.findAll();

        //查询某个roldId拥有的菜单
        List<Integer>  ownMenuIds=this.sysMenuMapper.findOwnMenuId(roleId);

        for(SysMenu  menu : allMenu){
            //新建MenuTreeVO
            MenuTreeVO vo=new MenuTreeVO();
            vo.setId(menu.getId());
            vo.setMenuName(menu.getMenuName());
            //根节点
            vo.setPId(menu.getParentId());
            vo.setOpen(true);
            //是否有选中(是否有权限)
            if(ownMenuIds.contains(  menu.getId())){
                vo.setChecked(true);
            }
            allMenuTreeVo.add(vo);
        }
        return allMenuTreeVo;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean saveAuthority(int roleId, String authority) {

        //删除用户的所有菜单权限
        this.sysMenuMapper.deleteAllRoleAuthority( roleId);

        //分解
        String[] arrString=authority.split("-");

        List<Integer> arrMenuIds=new ArrayList<Integer>(arrString.length);
        for(String s :arrString){
            arrMenuIds.add(Integer.parseInt(s));
        }

        //批量新增
        int count=this.sysMenuMapper.saveAuthority(roleId,arrMenuIds);
        return count>0;
    }


    //递归
    private void parentLevel(StringBuffer str,Integer parentId ,Integer menuLevel){
        if(menuLevel==1){
            return;
        }
        int i = this.findOne(parentId).getParentId();
        parentLevel(str, i,--menuLevel);
        str.append(i + "|");
    }



    //根据用户ID查询它拥有的菜单
    @Override
    public List<MenuNavVO> searchUserOwnMenu(int userId) {
        //最终返回的结果
        List<MenuNavVO> returnMenu = new ArrayList<MenuNavVO>();

        //先去(redis)查询有是否有缓存
        String redisKey = this.leftMenuRedisKeyPriex + "_" + userId;

        String redisValue = "";

        //连接redis操作，这里就算有异常也不能够影响我的正常业务逻辑
        try {
            redisValue = this.jedisUtil.get(redisKey);
        } catch (Exception e) {
            super.logger.error(e.getMessage());
        }


        //值不为空
        if (StringUtils.isNotBlank(redisValue)) {
            returnMenu = JSONArray.parseArray(redisValue, MenuNavVO.class);
        } else {
            //查询数据库
            List<SysMenu> allMenu = this.sysMenuMapper.searchUserOwnMenu(userId);
            //自定义数据，前端才能循环
            for (SysMenu m : allMenu) {
                if (m.getParentId() == 0) {
                    //第一次
                    MenuNavVO rootMenu = new MenuNavVO();
                    rootMenu.setId(m.getId());
                    rootMenu.setMenuName(m.getMenuName());
                    rootMenu.setActionName(m.getActionName());
                    rootMenu.setAuthority(m.getAuthority());
                    rootMenu.setParentId(m.getParentId());
                    //递归
                    menuRecurice(allMenu, rootMenu);
                    returnMenu.add(rootMenu);
                } else{
                    //优化,前提是一定把parentId排序
                    break;
                }
            }


            try {
                //存储到redis中，就算有错，也不要影响正常业务逻辑
                this.jedisUtil.set(redisKey, JSONArray.toJSONString(returnMenu));
                //设定redis有效期
                this.jedisUtil.setExpired(redisKey,timeout);
            } catch (Exception e) {
                super.logger.error(e.getMessage());
            }

        }
        return returnMenu;
    }

    private void menuRecurice(List<SysMenu> allMenu, MenuNavVO rootMenu) {
        List<MenuNavVO> childList=new ArrayList<MenuNavVO>();
        for(SysMenu  m1 : allMenu){
            if(m1.getParentId()==  rootMenu.getId()){
                MenuNavVO   childMenu=new MenuNavVO();
                childMenu.setId(m1.getId());
                childMenu.setMenuName(m1.getMenuName());
                childMenu.setActionName(m1.getActionName());
                childMenu.setAuthority(m1.getAuthority());
                childMenu.setParentId(m1.getParentId());
                //再调一次

                childList.add(childMenu);
            }
        }
        rootMenu.setChildren(childList);
    }

}
