package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.ShopAdv;
import com.hxzy.service.ShopAdvService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.PageSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "/manage")
public class ShopAdvController {

    @Autowired
    private ShopAdvService shopAdvService;

    @GetMapping(value = "/shopAdv")
    public String showPage() {
        return "shop/shopAdv";
    }

    @ResponseBody
    @PostMapping(value = "/shopAdv/search")
    public PageData<ShopAdv> findAll(PageSearch pageSearch) {
        PageData<ShopAdv> list = this.shopAdvService.searchPaging(pageSearch);
        return list;
    }

    @ResponseBody
    @PostMapping(value = "/shopAdv/updateDisplayorder")
    public JSONObject updateDisplayorder(ShopAdv shopAdv){
        System.out.println(shopAdv.getDisplayorder());
        JSONObject json = new JSONObject();
        boolean result = this.shopAdvService.updateSelective(shopAdv);
        if (result){
            json.put("code", 0);
            json.put("message", " 修改数据成功 ");
        }else {
            json.put("code", 500);
            json.put("message", " 修改失败");
        }
        return json;
    }

    @ResponseBody
    @PostMapping(value = "/shopAdv/updateEnabled")
    public JSONObject updateEnabled(ShopAdv shopAdv){
        System.out.println(shopAdv.getEnabled());
        JSONObject json = new JSONObject();
        boolean result = this.shopAdvService.updateSelective(shopAdv);
        if (result){
            json.put("code", 0);
            json.put("message", " 修改数据成功");
        }else {
            json.put("code", 500);
            json.put("message", " 修改失败");
        }
        return json;
    }

    @ResponseBody
    @PostMapping(value = "/shopAdv/save")
    public JSONObject add(ShopAdv shopAdv) {
        JSONObject json = new JSONObject();
        if (null != shopAdv.getId() && shopAdv.getId() > 0) {
            boolean result = this.shopAdvService.updateSelective(shopAdv);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "修改数据成功");
            } else {
                json.put("code", 500);
                json.put("message", "修改失败  ");
            }
        } else {
            boolean result = this.shopAdvService.insert(shopAdv);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "添加数据成功  ");
            } else {
                json.put("code", 500);
                json.put("message", "添加失败");
            }

        }

        return json;
    }

    @ResponseBody
    @PostMapping(value = "/shopAdv/delete")
    public JSONObject delete(int id){
        JSONObject jsonObject = new JSONObject();
        boolean delete = this.shopAdvService.delete(id);
        if (delete){
            jsonObject.put("code", 0);
            jsonObject.put("message","删除成功");
        }else{
            jsonObject.put("code", 500);
            jsonObject.put("message","删除失败");
        }

        return jsonObject;
    }

}
