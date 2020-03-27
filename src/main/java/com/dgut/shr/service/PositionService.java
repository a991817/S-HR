package com.dgut.shr.service;

import com.dgut.shr.dto.PositionDto;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/3/27 15:06
 */

public interface PositionService {
    public List<PositionDto> selectList(PositionDto dto);
}
