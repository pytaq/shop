package com.hxzy.admin.controller;

import org.springframework.stereotype.Controller;

/**
 * kineditor图片上传用的
 */
@Controller
public class KindeditorImageFastDFSController {

//    // http://kindeditor.net/docs/upload.html  查API返回格式
//   //图片支持的格式
//    private String imageExtends="gif,jpg,jpeg,png,bmp";
//
//    //fastdfs的nginx服务器地址
//    @Value("${fastdfs.url}")
//    private String fastdfsServer;
//
//    //单文件上传
//    @ResponseBody
//    @PostMapping(value = "/file/upload")
//    public JSONObject  uploadFile(MultipartFile imgFile) throws IOException, MyException {
//        JSONObject json=new JSONObject();
//
//       String fileName=imgFile.getOriginalFilename(); //文件名
//        //扩展名
//        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
//
//        //判断文件后是否是图片
//        if(!Arrays.<String>asList(imageExtends.split(",")).contains(fileExt)){
//           json.put("error",1);
//           json.put("message","上传文件扩展名是不允许的扩展名。\n只允许" + imageExtends + "格式。");
//           return json;
//        }
//
//        //最大文件大小字节为单位 500KB
//        long maxSize = 1024*500;
//        if(imgFile.getSize()>maxSize ){
//            json.put("error",1);
//            json.put("message","文件大小不能超过500KB");
//            return json;
//        }
//
//        //写入到FastDFS里面
//        ClientGlobal.init("fastdfs-config.properties");
//        TrackerClient tracker = new TrackerClient();
//        TrackerServer trackerServer = tracker.getConnection();
//        StorageServer storageServer = null;
//        StorageClient1 client = new StorageClient1(trackerServer, storageServer);
//
//       //自定义数据
//        NameValuePair[] metaList = new NameValuePair[2];
//        metaList[0] = new NameValuePair("fileName", fileName);  //文件名
//        metaList[1]= new NameValuePair("size",imgFile.getSize()+"");  //大小
//
//        String fileId = client.upload_file1(imgFile.getBytes(), fileExt, metaList);
//        System.out.println("upload success. file id is: " + fileId);
//
//        json.put("error",0);  //成功
//        json.put("url",fastdfsServer+fileId);
//
//        return json;
//    }

}
