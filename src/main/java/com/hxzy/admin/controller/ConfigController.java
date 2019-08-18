package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.Config;
import com.hxzy.service.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RequestMapping(value = "/manage")
@Controller
public class ConfigController {
    @Autowired
    private ConfigService configService;

    @GetMapping(value = "/config")
    public String search(Model model) {
        Config config = this.configService.find();
        model.addAttribute("obj", config);
        return "config/config";
    }

    @ResponseBody
    @PostMapping(value = "/config/save")
    public JSONObject saveConfig(Config config) {
        System.out.println(config);

        boolean result = this.configService.save(config);
        JSONObject json = new JSONObject();
        json.put("code", result ? 0 : 500);
        json.put("message", result ? "保存成功" : "保存失败");
        return json;
    }

}
