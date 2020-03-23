package com.dgut.shr.service.sys.impl;

import com.dgut.shr.service.sys.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;


@Service
public class RedisServiceImpl implements RedisService {
   @Autowired
    RedisTemplate redisTemplate;

//    public  User getUser(KeyPrefix keyPrefix, String key)
//    {
//            String realKey = keyPrefix.getPrefix() + ":"+ key ;
//            System.out.println("从缓存中取的key:"+realKey);
//            String str = (String) redisTemplate.opsForValue().get(realKey);
//            User t = stringToBean(str,User.class);
//            return t;
//    }
    public String get(String key)
    {
//            String realKey = keyPrefix.getPrefix() + ":"+ key ;
//            System.out.println("从缓存中取的key:"+realKey);
//            String str = (String) redisTemplate.opsForValue().get(realKey);
            String str = (String) redisTemplate.opsForValue().get(key);
            return str;
    }

//    public <T> boolean set(KeyPrefix keyPrefix, String key, T value)
    public  boolean set(String key, String value, long seconds)
    {

//            String realKey = keyPrefix.getPrefix() + ":"+ key ;
//            String str = beanToString(value);
//            redisTemplate.opsForValue().set(realKey,str);
           redisTemplate.opsForValue().set(key,value);
            if(seconds>0) {
                //生存时间大于0才设置，等于0表示永久有效
                //设置key生存时间，当key过期时，它会被自动删除。
                redisTemplate.expire(key,seconds,TimeUnit.SECONDS);
            }
            System.out.println("保存到缓存中的key:"+key+";值："+value);
            return true;

    }
//删除一个缓存
//    public <T> boolean delete(KeyPrefix keyPrefix, String key)
    public boolean delete(String key)
    {
//            String realKey = keyPrefix.getPrefix() + ":"+ key ;
            redisTemplate.delete(key);
            return true;
    }

    //减一
//    public <T> long decr(KeyPrefix keyPrefix, String key)
    public long decr( String key)
    {
//            String realKey = keyPrefix.getPrefix() + ":"+ key ;
//            return jedis.decr(realKey);
            return redisTemplate.opsForValue().increment(key,-1);
    }




}
