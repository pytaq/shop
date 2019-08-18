package com.hxzy.common.util;


import java.util.Date;

public class DateUtil {

    /**
     * 把日期转换成秒(删除毫秒)
     * @param date
     * @return
     */
    public static int dateToInt(Date date){
        return  (int)(date.getTime()/1000);
    }

    /**
     * 把数字转日期
     * @param seconds
     * @return
     */
    public static Date intToDate(int seconds){
        return new Date(seconds*1000L);
    }


}
