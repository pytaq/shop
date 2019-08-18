package com.hxzy.admin.controller;

import com.hxzy.service.DataBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

//数据库表操作
@RequestMapping(value="/manage")
@Controller
public class DataBaseController {

    @Autowired
    private DataBaseService dbService;

    @RequestMapping("/database/{dbName}")
    public String  showDataBaseName(@PathVariable String dbName, Model model){

        List<String> dbTables=this.dbService.findAllTableNames(dbName);
        model.addAttribute("dbTables",dbTables);
        model.addAttribute("databaseName",dbName);
        return "db/dbNames";
    }

    //得到数据库表结构

    @GetMapping(value = "/database/{dbName}/{tableName}")
    public void showTableDesc(@PathVariable("dbName") String dbName, @PathVariable("tableName") String tableName, HttpServletResponse resp){

        String str= this.dbService.findTableDesc(dbName,tableName);

        try {
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=UTF-8");
            PrintWriter out=resp.getWriter();
            out.println(str);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }



}
