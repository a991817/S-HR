package com.dgut.shr.service.sys;

public interface RedisService {
     String get(String key);
     boolean set(String key, String value, long seconds);
     boolean delete(String key);
     long decr( String key);
}
