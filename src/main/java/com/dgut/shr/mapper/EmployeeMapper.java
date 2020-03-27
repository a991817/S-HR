package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface EmployeeMapper extends BaseMapper<Employee> {

    Employee findUserByNameAndPwd(EmployeeDto userDto);

    int countAllEmployee();

    List<EmployeeDto> selectList(EmployeeDto dto);
}
