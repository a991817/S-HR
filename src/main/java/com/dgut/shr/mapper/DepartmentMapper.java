package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Department;
import com.dgut.shr.javaBean.Employee;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DepartmentMapper extends BaseMapper<Department> {

    /**
     * 查询部门的元信息
     * @param dto
     * @return
     */
    List<DepartmentDto> selectList(DepartmentDto dto);

    /**
     * 部门总数
     * @return
     */
    int countAllDepartment();

    /**
     * 查询部门详细信息，包括部门领导
     * @param dto
     * @return
     */
    List<DepartmentDto> selectDepInfo(DepartmentDto dto);

    /**
     * 新增一个部门
     * @param Dto
     * @return
     */
    int addDepartment(DepartmentDto Dto);

    /**
     * 更新一个部门
     * @param Dto
     * @return
     */
    int updateDepartment(DepartmentDto Dto);

    /**
     * 删除一个部门
     * @param Dto
     * @return
     */
    int deleteDepartment(DepartmentDto Dto);

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
}
