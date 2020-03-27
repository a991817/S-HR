package com.dgut.shr.service.impl;

import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.dto.PositionDto;
import com.dgut.shr.mapper.PositionMapper;
import com.dgut.shr.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/3/27 15:07
 */

@Service("positionService")
public class PositionServiceImpl implements PositionService {
    @Autowired
    PositionMapper positionMapper;
    @Override
    public List<PositionDto> selectList(PositionDto dto) {
        return positionMapper.selectList(dto);
    }
}
