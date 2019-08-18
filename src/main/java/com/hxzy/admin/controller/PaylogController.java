package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.Paylog;
import com.hxzy.service.PaylogService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.PageSearch;
import com.hxzy.vo.PaylogSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping(value = "/manage")
@Controller
public class PaylogController {

    @Autowired
    private PaylogService paylogService;

    @GetMapping(value = "/paylog")
    public String showPaylog(){
        return "paylog/paylog";
    }

    @ResponseBody
    @PostMapping(value = "/paylog/search")
    public List<Paylog> findone(){
        List<Paylog> list = this.paylogService.findAll();
        return list;
        //PageData<Paylog> pageData = this.paylogService.searchPaging(paylogSearch);
        //return pageData;
    }


    @ResponseBody
    @PostMapping(value = "/paylog/exist")
    public JSONObject exist(Paylog paylog) {
        JSONObject json = new JSONObject();
        boolean valid = false;
        if (null != paylog.getId() && paylog.getId() > 0) {
            Paylog one = this.paylogService.findOne(paylog.getId());
            if (!one.getPaytype().equals(paylog.getPaytype())) {
                valid = this.paylogService.existsValue(paylog);
            }
        } else {
            valid =this.paylogService.existsValue(paylog);
        }
        json.put("valid", !valid);
        return json;
    }

    @ResponseBody
    @PostMapping(value = "/paylog/save")
    public JSONObject add(Paylog paylog) {
        JSONObject json = new JSONObject();
        if (null != paylog.getId() && paylog.getId() > 0) {
            boolean result = this.paylogService.updateSelective(paylog);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "修改数据成功");
            } else {
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        } else {
            boolean result = this.paylogService.insert(paylog);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "添加数据成功");
            } else {
                json.put("code", 500);
                json.put("message", "添加失败");
            }

        }

        return json;
    }

}


