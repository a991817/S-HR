package com.dgut.shr.service;

import com.dgut.shr.dto.PositionDto;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/3/27 15:06
 */

public interface PositionService {
    List<PositionDto> selectList(PositionDto dto);

    /**
     * 新增一个部门
     * @param dto
     * @return
     */
    int addPosition(PositionDto dto);

    /**
     * 更新一个部门
     * @param dto
     * @return
     */
    int updatePosition(PositionDto dto);

    /**
     * 删除一个部门
     * @param dto
     * @return
     */
    int deletePosition(PositionDto dto);

    /**
     * 批量删除部门
     * @param ids
     * @return
     */
    int deletePositionMany(String[] ids);

    /**
     * 查找某个部门存不存在
     * @param Dto
     * @return
     */
    PositionDto getPositionBy(PositionDto Dto);
}
