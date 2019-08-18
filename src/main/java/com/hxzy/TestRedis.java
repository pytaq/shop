package com.hxzy;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.common.util.JedisUtil;
import com.hxzy.entity.User;
import com.hxzy.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "classpath:spring-application.xml")
public class TestRedis {

    @Autowired
    private JedisUtil  jedisUtil;
    @Autowired
    private UserService  userService;

    public  String getUniqueOrder() {
        SimpleDateFormat format = new SimpleDateFormat("YYYYMMddHHmmss");
        String format2 = format.format(new Date());
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if(hashCodeV < 0) {
            //有可能是负数
            hashCodeV = - hashCodeV;
        }
        return format2+String.format("%012d", hashCodeV);
    }

    @Test
    public void testOrderId(){
        Set<String> st=new HashSet<String>();

        Thread th1=new Thread(new Runnable() {
            @Override
            public void run() {
                for(int i=1;i<=10;i++){
                    String id=getUniqueOrder();
                    st.add(id);
                }
            }
        });

        Thread th2=new Thread(new Runnable() {
            @Override
            public void run() {
                for(int i=1;i<=10;i++){
                    String id=getUniqueOrder();
                    st.add(id);
                }
            }
        });

        //线程池
        ExecutorService executor= Executors.newFixedThreadPool(2);
        executor.execute(th1);
        executor.execute(th2);
        executor.shutdown();
        //结束
        while(true){
            if(executor.isTerminated()){
                System.out.println(st);
                System.out.println(st.size());
                break;
            }
            try {
                Thread.sleep(200);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

    }

    //新增
    @Test
    public void testAdd(){
//        jedisUtil.set("myRedis01","这是测试");
//        String result=jedisUtil.get("myRedis01");
//        System.out.println(result);
        System.out.println(UUID.randomUUID().toString());
    }

    @Test
    public void testAddJson(){
       User dbUser=this.userService.findOne(1);
       //java -->字符串
       // java-->fastjson-->字符串

        jedisUtil.set("currentUser", JSONObject.toJSONString(dbUser));
        String result=jedisUtil.get("currentUser");
        System.out.println(result);

        //字符串-->Java
        //字符串-->fastjson-->java
        User  myUser=JSONObject.parseObject(result,User.class);
        System.out.println(myUser);

    }

    //设定某个键的有效期
    @Test
    public void testKeyExpired(){
        jedisUtil.setExpired("currentUser",3);
    }
}
