package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.BonusDto;
import com.dgut.shr.dto.SettingDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BonusMapper extends BaseMapper {
    int insertBatch(BonusDto dto);

    int deleteBatch(BonusDto dto);
}
