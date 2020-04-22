package com.dgut.shr.service;

import com.dgut.shr.dto.BonusDto;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/22 18:45
 */
public interface BonusService {
    int insertBatch(BonusDto dto);

    int insertBatch(String[] ids,String bonus);

    List<BonusDto> selectBonus(BonusDto dto);
}
