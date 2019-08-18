package com.hxzy.vo;


import lombok.Data;

@Data
public class MenmberSearch extends PageSearch {

    private String email;
    private String realname;
    private  String mobile;

}
