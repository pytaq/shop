package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.vo.FileVO;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

//模板显示
@Controller
@RequestMapping(value = "/manage")
public class TemplateController {

    //显示页面
    @GetMapping(value = "/template/list")
    public String showPage(){
        return "template/list";
    }

    //读取所有的文件
    @ResponseBody
    @RequestMapping(value ="/template/allfile")
    public List<FileVO> getAllAdminTemplate(HttpServletRequest req){
        List<FileVO> arrVO=loadAllFile(req);

        return arrVO;
    }

    private List<FileVO> loadAllFile(HttpServletRequest req){
        //保存所有的文件
        List<FileVO> allFileVo=new ArrayList<FileVO>();
       //  F:\shop\target\shop\WEB-INF\admin
        String path = req.getServletContext().getRealPath("/WEB-INF/admin/");
        File directory=new File(path);

        if(directory.exists()){
            //得到文件夹下面的所有文件
            File[] allFile=directory.listFiles();

            for(File fi : allFile){
                FileVO vo=new FileVO();
                vo.setText(fi.getName());
                vo.setFileAbstractAddress(fi.getAbsolutePath());
               //如果是文件夹递归
                if(fi.isDirectory()){
                    vo.setFileType(1);
                    //递归文件夹
                    recuriceFile(fi,vo);
                    allFileVo.add(vo);
                }else{
                    vo.setFileType(2);
                    allFileVo.add(vo);
                }
            }
        }
        return allFileVo;
    }

    //递归操作
    private void recuriceFile(File directory, FileVO parent){
       File[] childFile=directory.listFiles();
       //有子文件
       if(childFile.length>0){
           parent.setNodes(new ArrayList<FileVO>());
       }
        for(File fi : childFile){
            FileVO vo=new FileVO();
            vo.setText(fi.getName());
            vo.setFileAbstractAddress(fi.getAbsolutePath());

            if(fi.isDirectory()){
                vo.setFileType(1);
                recuriceFile(fi,vo);
                parent.getNodes().add(vo);
            }else{
                vo.setFileType(2);
                parent.getNodes().add(vo);
            }
        }
    }

    //根据文件路径得到文件源码
    @RequestMapping(value = "/template/source")
    public void fileCode(HttpServletRequest req, HttpServletResponse resp) throws IOException {
       String filePath=req.getParameter("filePath");
       filePath=java.net.URLDecoder.decode(filePath,"UTF-8");
        System.out.println(filePath);
        StringBuffer str=new StringBuffer();

        File file=new File(filePath);
        if(file.exists()){

            List<String> listStr= FileUtils.readLines(file, "UTF-8");
            for(String s: listStr) {
                    str.append(s).append(" \r\n");
            }
        }

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out=resp.getWriter();
        out.println(str.toString());
        out.flush();
        out.close();
    }


    //保存文件
    @ResponseBody
    @RequestMapping(value = "/template/save")
    public String fileSave(HttpServletRequest req) throws IOException {

        String path= URLDecoder.decode(req.getParameter("filePath"),"UTF-8");
        String content=req.getParameter("content");

        System.out.println(path);
        System.out.println(content);

        //写入文件
        File file=new File(path);
        if(file.exists()){
             //编码格式设定
            FileWriter writer=new FileWriter(content);
            writer.write(content);
            writer.flush();
            writer.close();
        }

        JSONObject obj=new JSONObject();
        obj.put("code",0);
        obj.put("message","成功");
        return obj.toJSONString();
    }

}
