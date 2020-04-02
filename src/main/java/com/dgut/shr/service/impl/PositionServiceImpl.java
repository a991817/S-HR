package com.dgut.shr.service.impl;

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

    @Override
    public int addPosition(PositionDto dto) {
        return positionMapper.addPosition(dto);
    }

    @Override
    public int updatePosition(PositionDto dto) {
        return positionMapper.updatePosition(dto);
    }

    @Override
    public int deletePosition(PositionDto dto) {
        return positionMapper.deletePosition(dto);
    }

    @Override
    public int deletePositionMany(String[] ids) {
        return positionMapper.deletePositionMany(ids);
    }

    @Override
    public PositionDto getPositionBy(PositionDto dto) {
        return positionMapper.getPositionBy(dto);
    }
}
