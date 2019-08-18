package com.hxzy.common.shiro;

import com.alibaba.fastjson.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.PrintWriter;
import java.util.Map;

public class ShiroUtils {

    protected final static Logger logger = LogManager.getLogger(ShiroUtils.class);


    /**
     * @Description: 是否是Ajax请求
     * @param request
     * @return
     */
    public static boolean isAjax(ServletRequest request){
        return "XMLHttpRequest".equalsIgnoreCase(((HttpServletRequest) request).getHeader("X-Requested-With"));
    }

    /**
     * @Description: response 输出JSON
     * @param response
     * @param resultMap
     */
    public static void out(ServletResponse response, Map<String, String> resultMap){

        PrintWriter out = null;
        try {
            response.setCharacterEncoding("UTF-8");
            out = response.getWriter();
            out.println(JSONObject.toJSONString(resultMap));
        } catch (Exception e) {
            logger.debug(e);
            logger.info("输出JSON报错!");
        }finally{
            if(null != out){
                out.flush();
                out.close();
            }
        }
    }





}
