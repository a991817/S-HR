package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;

import java.util.List;

public interface EmployeeMapper extends BaseMapper<Employee> {

    Employee findUserByNameAndPwd(EmployeeDto userDto);

    int countAllEmployee();

    List<Employee> selectList(EmployeeDto dto);
}
