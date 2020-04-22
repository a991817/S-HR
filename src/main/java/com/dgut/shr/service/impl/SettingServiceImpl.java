package com.dgut.shr.service.impl;

import com.dgut.shr.dto.SettingDto;
import com.dgut.shr.mapper.SettingMapper;
import com.dgut.shr.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author shijie_liu
 * @date 2020/4/22 17:57
 */
@Service("settingService")
public class SettingServiceImpl implements SettingService {

    @Autowired
    SettingMapper settingMapper;
    @Override
    public int insert(String key, String value) {
        SettingDto dto = new SettingDto();
        dto.setKey(key);
        dto.setValue(value);
        return settingMapper.insert(dto);
    }

    @Override
    public String getValue(String key) {
        return settingMapper.getValue(key);
    }

    @Override
    public int update(String key, String value) {
        SettingDto dto = new SettingDto();
        dto.setKey(key);
        dto.setValue(value);
        return settingMapper.update(dto);
    }
}
