package com.dgut.shr.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;
import com.dgut.shr.mapper.EmployeeMapper;
import com.dgut.shr.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("EmployeeService")
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public boolean existUserByUP(String username, String password) {
        EmployeeDto dto = new EmployeeDto();
        dto.setEmail(username);
        dto.setPassword(password);
        Employee userByNameAndPwd = employeeMapper.findUserByNameAndPwd(dto);
        if (userByNameAndPwd != null){
            return true;
        }
        return false;
    }

    @Override
    public int countAllEmployee() {
        return employeeMapper.countAllEmployee();
    }

    @Override
    public IPage<Employee> selectPage(Page<Employee> pageInfo, Wrapper<Employee> queryWrapper) {
        return employeeMapper.selectPage(pageInfo,queryWrapper);
    }

    @Override
    public List<EmployeeDto> selectList(EmployeeDto dto) {
        if (dto == null){
            dto = new EmployeeDto();
        }
        return employeeMapper.selectList(dto);
    }

    @Override
    public int addEmployee(EmployeeDto dto) {
        return employeeMapper.addEmployee(dto);
    }

    @Override
    public EmployeeDto getEmployeeByIdNumber(String idNumber) {
        return employeeMapper.getEmployeeByIdNumber(idNumber);
    }
}
