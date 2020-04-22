package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.BonusDto;
import com.dgut.shr.dto.SettingDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BonusMapper extends BaseMapper {
    int insertBatch(BonusDto dto);

    int deleteBatch(BonusDto dto);

    List<BonusDto> selectBonus(BonusDto dto);
}
