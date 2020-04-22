package com.dgut.shr.service;

/**
 * @author shijie_liu
 * @date 2020/4/22 17:57
 */
public interface SettingService {

    int insert(String key,String value);

    String getValue(String key);

    int update(String key,String value);
}
