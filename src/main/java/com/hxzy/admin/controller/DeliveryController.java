package com.hxzy.admin.controller;


import com.alibaba.fastjson.JSONObject;
import com.hxzy.entity.DeliveryMode;
import com.hxzy.service.DeliveryModeServlice;
import com.hxzy.vo.PageData;
import com.hxzy.vo.DeliverySearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/manage")
public class DeliveryController {


    @Autowired
    private DeliveryModeServlice deliveryModeServlice;

    /**
     * 显示页面
     *
     * @return
     */
    @GetMapping(value = "/delivery")
    public String showpage() {
        return "Delivery/delivery";
    }


    /**
     * 全查显示
     *
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/delivery/search")
    public PageData<DeliveryMode> findall(DeliverySearch deliverySearch) {
        PageData<DeliveryMode> pageData = deliveryModeServlice.searchPaging(deliverySearch);
        return pageData;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/delivery/delete")

    public JSONObject del(int id){
        JSONObject json = new JSONObject();
        boolean valid = this.deliveryModeServlice.delete(id);
       if (valid){
           json.put("code", 0);
           json.put("message", "删除数据成功");
       }else {
           json.put("code", 500);
           json.put("message", "删除数据失败");
       }
        return json;
    }



    @ResponseBody
    @PostMapping(value = "/delivery/exist")
    public JSONObject exist(DeliveryMode deliveryMode) {
        JSONObject json = new JSONObject();
        boolean valid = false;
        if (null != deliveryMode.getId() && deliveryMode.getId() > 0) {
            DeliveryMode one = this.deliveryModeServlice.findOne(deliveryMode.getId());
            System.out.println("这是一个对象:"+one.toString());

            if (!one.getDeliveryexplain().equals(deliveryMode.getDeliveryexplain())) {
                valid = this.deliveryModeServlice.existsValue(deliveryMode);
            }
        } else {
            valid =this.deliveryModeServlice.existsValue(deliveryMode);
        }
        json.put("valid", !valid);
        return json;
    }

    @ResponseBody
    @PostMapping(value = "/delivery/save")
    public JSONObject add(DeliveryMode deliveryMode) {
        JSONObject json = new JSONObject();
        if (null != deliveryMode.getId() && deliveryMode.getId() > 0) {
            boolean result = this.deliveryModeServlice.update(deliveryMode);//调后台业务逻辑
            if (result) {
                json.put("code", 0);
                json.put("message", "修改数据成功");
            } else {
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        } else {
            boolean result = this.deliveryModeServlice.insert(deliveryMode);//调后台业务逻辑
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
