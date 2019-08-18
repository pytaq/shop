package com.hxzy.admin.controller;


import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.util.DateUtil;
import com.hxzy.entity.ShopCategory;
import com.hxzy.entity.ShopGoods;
import com.hxzy.service.ShopCategoryService;
import com.hxzy.service.ShopGoodsService;
import com.hxzy.vo.PageData;
import com.hxzy.vo.ShopGoodsSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/manage")
public class ShopGoodsController {


   @Autowired
   private ShopGoodsService service;

   @Autowired
   private ShopCategoryService categoryService;


   @GetMapping(value = "/shopgoods")
   public String showgoods() {
      return "shopGoods/shopgoods";
   }


   //显示新增商品品页面
   @GetMapping(value = "/goods/add")
   public  String showadd(Model model){
       //加载一级、二级、三级分类，并且 有联动效果
       List<ShopCategory>  firstCategory=this.categoryService.searchByParentId(0);
       model.addAttribute("first",firstCategory);

       int firstParentId = firstCategory.get(0).getId();
       List<ShopCategory> secondCategory = this.categoryService.searchByParentId(firstParentId);
       model.addAttribute("second",secondCategory);

       int secndParentId=secondCategory.get(0).getId();
       List<ShopCategory> thirdCategory=this.categoryService.searchByParentId(secndParentId);
       model.addAttribute("third",thirdCategory);

      return "shopGoods/addshopgoods";
   }


   @ResponseBody
   @PostMapping(value = "/shopgoods/search")
   public PageData<ShopGoods> searchAll(ShopGoodsSearch shopGoodsSearch) {
      PageData<ShopGoods> shop = this.service.searchPaging(shopGoodsSearch);
      System.out.println(shop.getTotal());
      for(ShopGoods s:shop.getRows()){
         System.out.println(s.toString());
      }
      return shop;

   }

   @ResponseBody
   @PostMapping(value = "/shopgoods/exit")
   public JSONObject exit(ShopGoods shopGoods) {
      JSONObject json = new JSONObject();
      boolean valid = false;
      if (shopGoods.getId() == 0) {
         valid = this.service.existsValue(shopGoods);
      } else if (shopGoods.getId() != null && shopGoods.getId() > 0) {
         ShopGoods one = this.service.findOne(shopGoods.getId());
         if(shopGoods.getTitle()!=null) {
            if (!shopGoods.getTitle().equals(one.getTitle())) {
               valid = this.service.existsValue(shopGoods);
            }
         }
         if(shopGoods.getGoodssn()!=null) {
            if (!shopGoods.getGoodssn().equals(one.getGoodssn())) {
               valid = this.service.existsValue(shopGoods);
            }
         }

      }
      json.put("valid", !valid);
      return json;
   }

   @ResponseBody
   @PostMapping(value = "/shopgoods/findone")
   public  ShopGoods finone(int  id){
      ShopGoods one = this.service.findOne(id);
      return one;
   }


   @ResponseBody
   @PostMapping(value = "/shopgoods/save")
   public JSONObject save(ShopGoods shopGoods) {
      JSONObject json = new JSONObject();
      if (shopGoods.getId() != null && shopGoods.getId() > 0) {
         boolean b = this.service.updateSelective(shopGoods);
         if (b) {
            json.put("code", 0);
            json.put("message", "修改数据成功");
         } else {
            json.put("code", 500);
            json.put("message", "修改失败");
         }
      } else {
         shopGoods.setCreatetime(DateUtil.dateToInt(new Date()));
         boolean insert = this.service.insertSelective(shopGoods);
         if (insert) {
            json.put("code", 0);
            json.put("message", "添加数据成功");
         } else {
            json.put("code", 500);
            json.put("message", "添加失败");
         }


      }
      return  json;
   }

}
