package com.dgut.shr.service.sys;

public interface RedisService {
     String get(String key);
     boolean set(String key, String value, long seconds);
     boolean delete(String key);
     long decr( String key);
     <T> T getValue(String key, Class<T> clazz) ;
     <T> boolean setValue(String key, T value, long seconds);
}
