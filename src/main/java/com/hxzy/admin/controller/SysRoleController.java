package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.SysRole;
import com.hxzy.service.SysRoleService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.SysRoleSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/manage")

public class SysRoleController {

    @Autowired
    private SysRoleService sysRoleService;
    //显示页面
    @GetMapping("/sysRole")
    public String showSysRole() {
        // 拥有    role:edit <button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>
        //   role:user       <button type="button" class="autoUser btn  btn-success"><i class="fa fa-pencil-square-o" ></i>&nbsp;分配用户</button>
        //  role:menu      <button type="button" class="autoMenu btn  btn-info"><i class="fa fa-pencil-square-o" ></i>&nbsp;分配菜单权限</button>
        //角色为  adminstrator  全部都 有



        /*
         '<button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>' +
        ' <button type="button" class="autoUser btn  btn-success"><i class="fa fa-pencil-square-o" ></i>&nbsp;分配用户</button>'+
         ' <button type="button" class="autoMenu btn  btn-info"><i class="fa fa-pencil-square-o" ></i>&nbsp;分配菜单权限</button>';
         */
        return "/sysRole/list";
    }
    //分页查询
    @ResponseBody
    @PostMapping("/sysRole/search")
    public PageData<SysRole> sreachAll(SysRoleSearch sysRoleSearch) {
        PageData<SysRole> sysRolePageData = this.sysRoleService.searchPaging(sysRoleSearch);
        return sysRolePageData;
    }
    //验证角色是否存在
    @ResponseBody
    @PostMapping("/sysRole/exist")
    public JSONObject exit(SysRole sysRole) {
        JSONObject json = new JSONObject();
        boolean valid = false;
        if (null != sysRole.getId() && sysRole.getId() >0) {
            SysRole one = this.sysRoleService.findOne(sysRole.getId());
            if (!one.getRolename().equals(sysRole.getRolename())) {
                valid=this.sysRoleService.existsVaule(sysRole);
            }
            if (!one.getAuthority().equals(sysRole.getAuthority())) {
                valid=this.sysRoleService.existsVaule(sysRole);
            }
        }else {
            //新增
            valid=this.sysRoleService.existsVaule(sysRole);
        }
        json.put("valid", !valid);
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/sysRole/save")
    public JSONObject save(SysRole sysRole) {
        System.out.println(sysRole);
        JSONObject json = new JSONObject();
        boolean result=false;
        if ( null == sysRole.getId()) {
             result = this.sysRoleService.insert(sysRole);
            if(result){
                json.put("code", 0);
                json.put("message", "修改数据成功");
            }else{
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        }else {
             result = this.sysRoleService.updateSelective(sysRole);//调后台业务逻辑
            if(result){
                json.put("code", 0);
                json.put("message", "修改成功");
            }else{
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        }
        return json;

    }


}
