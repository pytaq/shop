package com.hxzy.vo;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 文件相关的信息
 */
@Data
public class FileVO {
    private String text;
    private int fileType; //1文件夹，2文件
    private String fileAbstractAddress; //文件绝对地址


    private List<FileVO> nodes;  //子节点

}
