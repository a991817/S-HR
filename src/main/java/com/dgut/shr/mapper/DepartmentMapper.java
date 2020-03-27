package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.javaBean.Department;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DepartmentMapper extends BaseMapper<Department> {

    List<DepartmentDto> selectListFuck1(DepartmentDto dto);

    int countAllDepartment();
}
