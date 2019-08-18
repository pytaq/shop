package com.hxzy.admin.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.SysRole;
import com.hxzy.entity.User;
import com.hxzy.service.SysRoleService;
import com.hxzy.service.UserService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.SysRoleUserSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(value = "/manage")
public class SysRoleUserController {

    @Autowired
    private UserService userService;

    @Autowired
    private SysRoleService sysRoleService;


    //根据角色ID查询角色配的界面
    @GetMapping(value = "/roleUser/{roleId}")
    public String showPage(@PathVariable int roleId, Model model){
        SysRole  role= sysRoleService.findOne(roleId);
        model.addAttribute("role",role);
        return "sysRoleUser/list";
    }

    //已经拥有该角色的用户
    @ResponseBody
    @PostMapping(value = "/roleUser/ownuser/{roleId}")
    public PageData<User> sreachOwnRoleUser(SysRoleUserSearch sysRoleUserSearch) {
      PageData<User> pageData= this.userService.findOwnUser(sysRoleUserSearch);
      return pageData;
    }

    //没有分配该角色的用户
    @ResponseBody
    @PostMapping(value = "/roleUser/nouser/{roleId}")
    public PageData<User> sreachNoOwnRoleUser(SysRoleUserSearch sysRoleUserSearch) {
        PageData<User> pageData= this.userService.findNoOwnUser(sysRoleUserSearch);
        return pageData;
    }

    //为该角色添加用户
    @ResponseBody
    @RequestMapping(value = "/roleUser/add/roleId/{roleId}/userId/{userId}")
    public JSONObject addOwnUser(@PathVariable("userId") int userId,@PathVariable("roleId")int roleId){
       boolean result=  this.userService.insertOwnUserId(userId,roleId);

       JSONObject  json=new JSONObject();
       json.put("code", result?0:500);
       json.put("message",result?"分配用户成功":"分配用户失败!");

       return json;
    }

    //为移该已拥有用户id
    @ResponseBody
    @RequestMapping(value = "/roleUser/remove/roleId/{roleId}/userId/{userId}")
    public JSONObject removeOwnUser(@PathVariable("userId") int userId,@PathVariable("roleId")int roleId){
        boolean result=  this.userService.deleteOwnUserId(userId,roleId);

        JSONObject  json=new JSONObject();
        json.put("code", result?0:500);
        json.put("message",result?"用户移出角色成功":"用户移出角色失败!");
        return json;
    }
}
