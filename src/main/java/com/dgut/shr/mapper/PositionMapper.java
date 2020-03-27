package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.PositionDto;
import com.dgut.shr.javaBean.Position;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/3/27 15:03
 */
@Mapper
public interface PositionMapper extends BaseMapper<Position> {

    int countAllEmployee();

    List<PositionDto> selectList(PositionDto dto);
}
