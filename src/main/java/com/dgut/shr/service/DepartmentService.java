package com.dgut.shr.service;
import com.dgut.shr.dto.DepartmentDto;
import java.util.List;

public interface DepartmentService {
    /**
     * 获取部门所有信息
     * @param dto
     * @return
     */
    List<DepartmentDto> selectList(DepartmentDto dto);
}
