package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.SysMenu;
import com.hxzy.entity.SysRole;
import com.hxzy.service.SysMenuService;
import com.hxzy.service.SysRoleService;
import com.hxzy.vo.MenuTreeVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping(value = "manage")
public class MenuController {
    @Autowired
    private SysMenuService sysMenuService;

    @Autowired
    private SysRoleService  roleService;

    @GetMapping(value = "/menu")
    public String  menuShow(){
        return "sysMenu/list";
    }

    /**
     * 显示表格
     * @param sysMenu
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/menu/search")
    public List<SysMenu> showAll(SysMenu sysMenu){
        List<SysMenu> search=  this.sysMenuService.search(sysMenu);
        return search;
    }

    /**
     * 验证
     * @param sysMenu
     * @return
     */
    @ResponseBody
    @PostMapping("/menu/exist")
    public JSONObject exist(SysMenu sysMenu){
        JSONObject json = new JSONObject();
        System.out.println("验证sysMenu："+sysMenu.toString());
        Boolean valid = this.sysMenuService.exist(sysMenu);
        json.put("valid", valid);
        return json;
    }

    /**
     * 新增，修改，保存
     * @param sysMenu
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/menu/save")
    public JSONObject add(SysMenu sysMenu) {
        System.out.println(sysMenu.toString());
        JSONObject json = new JSONObject();

        //判断是否为空
        if (StringUtils.isBlank(sysMenu.getActionName())) {
            sysMenu.setActionName(null);
        }
        if (StringUtils.isBlank(sysMenu.getAuthority())) {
            sysMenu.setAuthority(null);
        }
        if (null != sysMenu.getId() && sysMenu.getId() > 0) {

            boolean result = sysMenuService.updateSelective(sysMenu);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "修改数据成功");
            } else {
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        } else {//新增
            boolean result = sysMenuService.insert(sysMenu);
            if (result) {
                json.put("code", 0);
                json.put("message", "添加成功");
            } else {
                json.put("code", 500);
                json.put("message", "添加失败");
            }
        }
        return json;
    }

    /**
     * 更新dispaly
     * @param sysMenu
     * @return
     */
    @ResponseBody
    @PostMapping("/menu/display")
    public JSONObject updateDisplay(SysMenu sysMenu){
        JSONObject json = new JSONObject();
        boolean result = this.sysMenuService.updateSelective(sysMenu);
        json.put("result", result);
        return json;
    }


    /**
     * 显示角色拥有的菜单页面
     * @param roleId
     * @return
     */
    @RequestMapping(value = "/menu/authority/roleId/{roleId}")
    public String showRoleOwnMenuPage(@PathVariable Integer roleId, Model model){
        SysRole  role=this.roleService.findOne(roleId);
        model.addAttribute("role",role);
        return "sysRoleMenu/list";
    }

    //得到某个用户拥有的权限
    @ResponseBody
    @RequestMapping(value = "/menu/roleId/{roleId}/authority")
    public List<MenuTreeVO>  getRoleOwnMenu(@PathVariable  Integer roleId){
        List<MenuTreeVO>  ownTreeVo=this.sysMenuService.findRoleOwnMenu(roleId);
        return ownTreeVo;
    }

    //保存角色的菜单权限
    @ResponseBody
    @PostMapping(value = "/menu/authority/save")
    public JSONObject  saveAuthority(int roleId,String authority){

       boolean result= this.sysMenuService.saveAuthority(roleId,authority);

       JSONObject  json=new JSONObject();
       json.put("code",result?0:500);
       json.put("message",result?"分权菜单权限成功":"分配菜单权限失败");
       return json;
    }

}
