package com.hxzy.admin.controller;

import com.hxzy.entity.User;
import com.hxzy.service.SysMenuService;
import com.hxzy.vo.MenuNavVO;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/manage")
public class HomeController {

    @Autowired
    private SysMenuService menuService;

    //后台首页
    @GetMapping(value ={"","/index"})
    public String index(HttpSession session, Model model){
        //当前用户ID，查询权限

        User user=(User) SecurityUtils.getSubject().getPrincipal();
        int userId=user.getId();
        //先去(redis)查询有是否有缓存
        List<MenuNavVO>  leftMenuVo=this.menuService.searchUserOwnMenu(userId);
        model.addAttribute("leftMenu",leftMenuVo);

        return "index";
    }


    //后台home报表页
    @GetMapping(value = "/home")
    public String home(){
        return "home";
    }
}
