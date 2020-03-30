package com.dgut.shr.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dgut.shr.dto.DepartmentDto;
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

    /**
     * 查询员工列表
     * @param dto
     * @return
     */
    List<EmployeeDto> selectList(EmployeeDto dto);

    /**
     * 新增一个员工
     * @param dto
     * @return
     */
    int addEmployee(EmployeeDto dto);

    /**
     * 根据身份证或者工号查询员工
     * @param dto
     * @return
     */
    EmployeeDto getEmployeeBy(EmployeeDto dto);

    /**
     * 更新一个员工
     * @param dto
     * @return
     */
    int updateEmployee(EmployeeDto dto);

    /**
     * 删除一个员工
     * @param dto
     * @return
     */
    int deleteEmployee(EmployeeDto dto);

    /**
     * 批量删除员工
     * @param ids
     * @return
     */
    int deleteEmployeeMany(String[] ids);
}
