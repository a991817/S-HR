package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.AdminDto;
import com.dgut.shr.dto.SettingDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SettingMapper extends BaseMapper {

    int insert(SettingDto dto);

    String getValue(String key);

    int update(SettingDto dto);
}
