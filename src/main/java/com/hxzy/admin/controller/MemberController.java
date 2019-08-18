package com.hxzy.admin.controller;
import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.util.DateUtil;
import com.hxzy.entity.Member;
import com.hxzy.service.MemberService;
import com.hxzy.vo.MenmberSearch;
import com.hxzy.vo.PageData;
import com.hxzy.vo.PageSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/manage")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @GetMapping(value = "/member")
    public String showMember(){
        return "member/list";
    }

    //查询全部
    @ResponseBody
    @RequestMapping(value = "/member/sreach")
    public PageData<Member> sreachall(MenmberSearch menmberSearch) {
        PageData<Member> page = this.memberService.searchPaging(menmberSearch);
        return page;

    }

    //新增和查询
    @ResponseBody
    @PostMapping(value = "/member/add")
    public JSONObject add(Member member) {
        member.setCreatetime(DateUtil.dateToInt(new Date()));

        JSONObject json= new JSONObject();
        if(null!=member.getOpenid()){
            boolean result = this.memberService.updateSelective(member);//调后台业务逻辑
            if(result){
                json.put("code", 0);
                json.put("message", "修改数据成功");
            }else{
                json.put("code", 500);
                json.put("message", "修改失败");
            }
        }else{
            boolean result = this.memberService.insert(member);//调后台业务逻辑
            if(result){
                json.put("code", 0);
                json.put("message", "添加数据成功");
            }else{
                json.put("code", 500);
                json.put("message", "添加失败");
            }

        }
        return json;
    }

    //查询
    @ResponseBody
    @PostMapping(value = "/member/exist")
    public JSONObject exist(Member member){
        JSONObject json= new JSONObject();
        boolean valid=false;
        if(null!=member.getOpenid()){
            Member one = this.memberService.findOne(member.getOpenid());
            if(!one.getRealname().equals(member.getRealname())){
                valid = this.memberService.existsValue(member);
            }
        }else{
            valid=this.memberService.updateSelective(member);
        }
        json.put("valid", !valid);
        return json;
    }


}
