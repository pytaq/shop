package com.hxzy.common.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * Jedis工具类
 */
@Component
public class JedisUtil {

    private static final Logger logger = LogManager.getLogger(JedisUtil.class);


    @Autowired
    private JedisPool  pool;

   //字符串String操作

    /**
     * 新增键
     * @param key
     * @param value
     * @return
     */
   public String set(String key, String value){
      Jedis  jedis= pool.getResource();
      String result=jedis.set(key,value);
      jedis.close();  //还给连接池
      return result;
   }

    /**
     * 根据键取值
     * @param key
     * @return
     */
   public String get(String key){
       Jedis  jedis= pool.getResource();
       String result=jedis.get(key);
       jedis.close();
       return result;
   }

    /**
     * 根据删除删除值
     * @param key
     */
   public void delete(String key){
       Jedis  jedis= pool.getResource();
        long result=jedis.del(key);
       System.out.println("删除"+key+":"+result);
       jedis.close();
   }

    /**
     * 删除多个值
     * @param keys
     */
   public void delete(String ...keys){
       Jedis  jedis= pool.getResource();
       jedis.del(keys);
       jedis.close();
   }

    /**
     * 给某个键设定一个过期时间(秒为单位)
     * @param key
     * @param seconds 秒
     */
   public void setExpired(String key ,int seconds){
       Jedis  jedis= pool.getResource();
       jedis.expire(key,seconds);
       jedis.close();
   }

    /**
     * 添加一对key:value，并设置过期时间
     * @param key 键
     * @param expire 过期时间
     * @param value 值
     */
    public  void setex(String key, int expire, String value) {
        Jedis jedis = null;
        try {
            jedis =pool.getResource();
            jedis.setex(key, expire, value);
            logger.debug("setex：向缓存中添加数据，key：{}，value：{}，过期时间：{}秒", key, value, expire);
        } catch (Exception e) {
            logger.error("setex：向缓存中添加数据时出现异常，key：{}，value：{}，过期时间：{}秒", key, value, expire, e);
        } finally {
            //保证jedis被关闭（归还给连接池）
            jedis.close();
        }
    }

}
