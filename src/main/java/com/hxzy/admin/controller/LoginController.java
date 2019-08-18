package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.util.JedisUtil;
import com.hxzy.entity.User;
import com.hxzy.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

//登录或注销的控制器
@Controller
@RequestMapping(value = "/manage")
public class LoginController {

    private Logger logger= LogManager.getLogger(this);

    //菜单redis的前缀名称
    @Value("${leftmenu.redisKey}")
    private String leftMenuRedisKeyPriex;

    @Autowired
    private UserService userService;

    @Autowired
    private JedisUtil  jedisUtil;

    @GetMapping(value = "/user/logout")
    public String logout(HttpSession session){
      //清空缓存    //当前用户ID，查询权限
       User user=(User) SecurityUtils.getSubject().getPrincipal();
        int userId=user.getId();
        String redisKey = this.leftMenuRedisKeyPriex + "_" + userId;
        try{
            this.jedisUtil.delete(redisKey);
        }catch (Exception e){
            logger.error("登出注销redis菜单失败");
            logger.error(e.getMessage());
        }

        //退出
        SecurityUtils.getSubject().logout();

        return "redirect:/admin/manage/login";
    }

    //登录界面
    @GetMapping(value = "/login")
    public String login(){

        return "login";
    }

    //登录验证
    @ResponseBody
    @PostMapping(value = "/login")
    public JSONObject loginValidate(User user){
       JSONObject json=new JSONObject();

        Subject subject= SecurityUtils.getSubject();

        UsernamePasswordToken token=new UsernamePasswordToken(user.getUsername(),user.getPassword());

        try{
            subject.login(token);

            if(subject.isAuthenticated()){
                json.put("code",0);
                json.put("message","登录成功");
            }else{
                json.put("code",400);
                json.put("message","登录失败");
            }
        }catch (UnknownAccountException e1){
            json.put("code",404);
            json.put("message",e1.getMessage());
            logger.warn(e1.getMessage());
        }catch(IncorrectCredentialsException e2){
            json.put("code",500);
            json.put("message",e2.getMessage());
            logger.warn(e2.getMessage());
        }catch (AuthenticationException e3){
            json.put("code",505);
            json.put("message",e3.getMessage());
            logger.warn(e3.getMessage());
        }

        return json;
    }
}
