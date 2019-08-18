package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.ShopCategory;
import com.hxzy.service.ShopCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RequestMapping(value = "/manage")
@Controller
public class CategoryController {


    @Autowired
    private ShopCategoryService shopCategoryService;


    /**
     * 显示界面
     *
     * @return
     */
    @GetMapping(value = "/category")
    public String showcategory() {

        return "shop/category";
    }


    /**
     * 全查显示
     *
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/category/search")
    public List<ShopCategory> findall() {
        List<ShopCategory> list = this.shopCategoryService.findAll();
        return list;
    }

    @ResponseBody
    @PostMapping(value = "/category/exist")
    public JSONObject exist(ShopCategory shopCategory) {
        JSONObject json = new JSONObject();
        boolean valid = false;
        if (null != shopCategory.getId() && shopCategory.getId() > 0) {
            ShopCategory one = this.shopCategoryService.findOne(shopCategory.getId());
            if (!one.getName().equals(shopCategory.getName())) {
                valid = this.shopCategoryService.existsValue(shopCategory);
            }
        } else {
            valid =this.shopCategoryService.existsValue(shopCategory);
        }
        json.put("valid", !valid);
        return json;
    }

    @ResponseBody
    @PostMapping(value = "/category/save")
    public JSONObject add(ShopCategory shopCategory) {
        JSONObject json = new JSONObject();
        if (null != shopCategory.getId() && shopCategory.getId() > 0) {
            boolean result = this.shopCategoryService.updateSelective(shopCategory);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "修改数据成功");
            } else {
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        } else {
            boolean result = this.shopCategoryService.insert(shopCategory);//调后台业务逻辑
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


    //根据parentId查询数据
    @RequestMapping(value = "/category/parentId/{pid}")
    @ResponseBody
    public JSONObject getCategoryByParentId(@PathVariable("pid") int pid){
        List<ShopCategory> arr=this.shopCategoryService.searchByParentId(pid);
        JSONObject json=new JSONObject();
        json.put("code", 0);
        json.put("message", "ok");
        json.put("data",arr);
        return json;
    }

}
