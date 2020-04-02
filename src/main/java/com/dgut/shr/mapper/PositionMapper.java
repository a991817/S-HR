package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.DepartmentDto;
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

    /**
     * 新增一个职位
     * @param Dto
     * @return
     */
    int addPosition(PositionDto Dto);

    /**
     * 更新一个职位
     * @param Dto
     * @return
     */
    int updatePosition(PositionDto Dto);

    /**
     * 删除一个职位
     * @param Dto
     * @return
     */
    int deletePosition(PositionDto Dto);

    /**
     * 批量删除职位
     * @param ids
     * @return
     */
    int deletePositionMany(String[] ids);

    /**
     * 查找某个职位存不存在
     * @param Dto
     * @return
     */
    PositionDto getPositionBy(PositionDto Dto);
}
