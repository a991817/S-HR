package com.dgut.shr.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Address;
import com.dgut.shr.javaBean.Employee;
import com.dgut.shr.mapper.AddressMapper;
import com.dgut.shr.mapper.EmployeeMapper;
import com.dgut.shr.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    AddressMapper addressMapper;

    @Override
    public boolean existUserByUP(String username, String password) {
        EmployeeDto dto = new EmployeeDto();
        dto.setEmail(username);
        dto.setPassword(password);
        EmployeeDto userByNameAndPwd = employeeMapper.findUserByNameAndPwd(dto);
        if (userByNameAndPwd != null){
            return true;
        }
        return false;
    }

    @Override
    public int countAllEmployee(EmployeeDto dto) {
        return employeeMapper.countAllEmployee(dto);
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
    public EmployeeDto getEmployeeBy(EmployeeDto dto) {
        EmployeeDto employee = employeeMapper.getEmployeeBy(dto);
//        查询地址
        Address address = addressMapper.getAddressByEmpId(employee);
        employee.setAddress(address);
        return employee;
    }

    @Override
    public int updateEmployee(EmployeeDto dto) {
//        更新员工信息
        int i = employeeMapper.updateEmployee(dto);
//        更新员工地址,需要判断这个地方是新增还是更新
        if (dto.getAddress() != null) {
            if (addressMapper.getAddressByEmpId(dto) == null) {
//         新增
                addressMapper.insertAddress(dto);
            } else {
//            更新
                addressMapper.updateAddress(dto);
            }
        }
        return i;
    }

    @Override
    public int deleteEmployee(EmployeeDto dto) {
        return employeeMapper.deleteEmployee(dto);
    }

    @Override
    public int deleteEmployeeMany(String[] ids) {
        return employeeMapper.deleteEmployeeMany(ids);
    }

    @Override
    public List<EmployeeDto> selectEmpIdList(EmployeeDto dto) {
        return employeeMapper.selectEmpIdList(dto);
    }

}
