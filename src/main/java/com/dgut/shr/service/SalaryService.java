package com.dgut.shr.service;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Salary;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/22 21:51
 */
public interface SalaryService {
    Result calculateSalary();

    List<Salary> getSalaryByEmp(EmployeeDto dto);
}
