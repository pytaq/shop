package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.User;
import com.hxzy.service.UserService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.UserSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RequestMapping(value = "/manage")
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping(value = "/user")
    public String showUser() {

        return "user/list";
    }

    @ResponseBody
    @RequestMapping(value = "/user/search")
    public PageData<User> searchALL(UserSearch userSearch) {
        PageData<User> userPageData = this.userService.searchPaging(userSearch);
        return userPageData;
    }

    //验证用户名是重复
    @ResponseBody
    @PostMapping(value = "/user/exist")
    public JSONObject exist(User user) {
        JSONObject json = new JSONObject();
        boolean valid = false;
        if (null != user.getId() && user.getId() > 0) {
            User one = this.userService.findOne(user.getId());
            if (!one.getUsername().equals(user.getUsername())) {
                valid = this.userService.existsValue(user);
            }
        } else {
            valid = this.userService.existsValue(user);
        }
        json.put("valid", !valid);
        return json;
    }


    @ResponseBody
    @PostMapping(value = "/user/save")
    public JSONObject save(User user) {
        JSONObject json = new JSONObject();

        boolean result = false;
        if (user.getId() == null) {
            result = this.userService.insert(user);
            if (result) {
                json.put("code", 0);
                json.put("message", "添加成功");
            } else {
                json.put("code", 500);
                json.put("message", "添加失败");
            }

        } else {
            result = this.userService.updateSelective(user);
            if (result) {
                json.put("code", 0);
                json.put("message", "修改成功");
            } else {
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        }
        return json;
    }

}
