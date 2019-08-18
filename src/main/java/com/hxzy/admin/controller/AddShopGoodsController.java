package com.hxzy.admin.controller;








import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(value = "/manage")
@Controller
public class AddShopGoodsController {

    @GetMapping(value = "/show")
    public  String showadd(){ return "shopGoods/add";
    }

}
