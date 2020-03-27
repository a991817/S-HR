package com.dgut.shr.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;

import java.util.List;

public interface EmployeeService {
    /**
     * 通过用户名和密码判断这个用户是否为合法用户
     * @param username
     * @param password
     * @return
     */
    boolean existUserByUP(String username ,String password);

    /**
     * 查询所有员工的总数
     * @return
     */
    int countAllEmployee();

    /**
     * 分页查询
     * @param pageInfo
     * @param queryWrapper
     * @return
     */
    IPage<Employee> selectPage(Page<Employee> pageInfo, Wrapper<Employee> queryWrapper);

    List<EmployeeDto> selectList(EmployeeDto dto);
}
