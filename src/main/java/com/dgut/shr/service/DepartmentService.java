package com.dgut.shr.service;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;

import java.util.List;

public interface DepartmentService {
    /**
     * 获取部门所有信息
     * @param dto
     * @return
     */
    List<DepartmentDto> selectList(DepartmentDto dto);

    /**
     * 获取部门详细信息，包括领导信息
     * @param dto
     * @return
     */
    List<DepartmentDto> selectDepInfo(DepartmentDto dto);

    /**
     * 新增一个部门
     * @param dto
     * @return
     */
    int addDepartment(DepartmentDto dto);

    /**
     * 更新一个部门
     * @param dto
     * @return
     */
    int updateDepartment(DepartmentDto dto);

    /**
     * 删除一个部门
     * @param dto
     * @return
     */
    int deleteDepartment(DepartmentDto dto);

    /**
     * 批量删除部门
     * @param ids
     * @return
     */
    int deleteDepartmentMany(String[] ids);

    /**
     * 查找某个部门存不存在
     * @param Dto
     * @return
     */
    DepartmentDto getDepartmentBy(DepartmentDto Dto);

    int countDepartment();
}
