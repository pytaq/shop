package com.hxzy.admin.controller;

import com.alibaba.fastjson.JSONObject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import static java.util.Arrays.asList;

/**
 * kineditor图片上传用的
 */
@Controller
public class KindeditorImageController {

    //图片存放的绝对磁盘地址
    @Value("${image.service.abstractPath}")
    private String savePath;
    //图片服务器URL
    @Value("${image.service.url}")
    private String saveUrl;
    //主机地址
    @Value("${image.service.hostName}")
    private String hostName;

    //kineditor文件上传
    @ResponseBody
    @PostMapping("/image/upload")
    public JSONObject  uploadFile(MultipartFile imgFile, HttpServletResponse response,HttpServletRequest request) throws IOException {
        //允许上传文件类型
        HashMap<String, String> extMap = new HashMap<String, String>();
        extMap.put("image", "gif,jpg,jpeg,png,bmp");
        extMap.put("flash", "swf,flv");
        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

        //最大文件大小字节为单位 5MB
        long maxSize = 5000000;
        response.setContentType("text/html; charset=UTF-8");

        if(imgFile.isEmpty()){
            return getError("请选择文件。");
        }

        //检查目录
        String savePathTemp=savePath;
        File uploadDir = new File(savePathTemp);
        if(!uploadDir.isDirectory()){
            return getError("上传目录不存在。");
        }

        //检查目录写权限(linux)
        if(!uploadDir.canWrite()){
            return  getError("上传目录没有写权限。");
        }

        //得到插件传过来参数
        String dirName = request.getParameter("dir");
        if (dirName == null) {
            dirName = "image";
        }

        if(!extMap.containsKey(dirName)){
            return getError("目录名不正确。");
        }

         //创建文件夹
        savePathTemp += dirName + "/";
        String saveUrlTemp=saveUrl;
        saveUrlTemp += dirName + "/";
        File saveDirFile = new File(savePathTemp);
        if (!saveDirFile.exists()) {
            saveDirFile.mkdirs();
        }

        //再创建子文件
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        savePathTemp += ymd + "/";
        saveUrlTemp += ymd + "/";
        File dirFile = new File(savePathTemp);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }

        //检查文件大小  >5MB
        if(imgFile.getSize()> maxSize){
            return getError("上传文件大小超过限制最多5MB。");
        }

        //检查扩展名
        System.out.println("fileName:"+imgFile.getName());
        System.out.println("OriginalFilename:"+imgFile.getOriginalFilename());
        String fileName=imgFile.getOriginalFilename();
        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){
            return  getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。");
        }

        //随机生成一个文件名  yyyyMMddHHmmss_随机数(1000)
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
        File uploadedFile = new File(savePathTemp, newFileName);

        try{
            imgFile.transferTo(uploadedFile);
        }catch(Exception e){
           return getError("上传文件失败。");
        }

        //写入到本地磁盘中去(成功返回0)
        JSONObject obj = new JSONObject();
        obj.put("error", 0);
        obj.put("url", hostName+saveUrlTemp + newFileName);
        return obj;
    }


    private JSONObject getError(String message) {
        JSONObject obj = new JSONObject();
        obj.put("error", 1);
        obj.put("message", message);
        return obj;
    }
}
