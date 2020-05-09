package com.dgut.shr.service.sys.impl;

import com.alibaba.fastjson.JSON;
import com.dgut.shr.service.sys.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;


@Service
public class RedisServiceImpl implements RedisService {
    @Autowired
    RedisTemplate redisTemplate;

    public String get(String key) {
        String str = (String) redisTemplate.opsForValue().get(key);
        return str;
    }


    public boolean set(String key, String value, long seconds) {

        redisTemplate.opsForValue().set(key, value);
        if (seconds > 0) {
            //生存时间大于0才设置，等于0表示永久有效
            //设置key生存时间，当key过期时，它会被自动删除。
            redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
        }
        System.out.println("保存到缓存中的key:" + key + ";值：" + value);
        return true;

    }

    //删除一个缓存
//    public <T> boolean delete(KeyPrefix keyPrefix, String key)
    public boolean delete(String key) {
        redisTemplate.delete(key);
        return true;
    }

    //减一
    public long decr(String key) {
        return redisTemplate.opsForValue().increment(key, -1);
    }

    public <T> boolean setValue(String key, T value, long seconds) {
        String str = beanToString(value);
        redisTemplate.opsForValue().set(key, str);
        if (seconds > 0) {
            //生存时间大于0才设置，等于0表示永久有效
            //设置key生存时间，当key过期时，它会被自动删除。
            redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
        }
        System.out.println("保存到缓存中的key:" + key + ";值：" + value);
        return true;
    }

    public <T> T getValue(String key, Class<T> clazz) {
        String str = (String) redisTemplate.opsForValue().get(key);
        System.out.println("从缓存中取的key:" + key);
        T t = stringToBean(str, clazz);
        return t;
    }

    public static <T> String beanToString(T value) {
        if (value == null) {
            return null;
        }
        Class<?> clazz = value.getClass();
        if (clazz == int.class || clazz == Integer.class) {
            return "" + value;
        } else if (clazz == String.class) {
            return (String) value;
        } else if (clazz == long.class || clazz == Long.class) {
            return "" + value;
        } else {
            return JSON.toJSONString(value);
        }
    }

    public static <T> T stringToBean(String str, Class<T> clazz) {
        if (str == null || str.length() <= 0 || clazz == null) {
            return null;
        }
        if (clazz == int.class || clazz == Integer.class) {
            return (T) Integer.valueOf(str);
        } else if (clazz == String.class) {
            return (T) str;
        } else if (clazz == long.class || clazz == Long.class) {
            return (T) Long.valueOf(str);
        } else {
            return JSON.toJavaObject(JSON.parseObject(str), clazz);
        }
    }
}
