package com.dgut.shr.service.sys.impl;

import com.dgut.shr.dto.AdminDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.mapper.AdminMapper;
import com.dgut.shr.mapper.EmployeeMapper;
import com.dgut.shr.service.sys.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    AdminMapper adminMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 通过用户名和密码判断是不是管理员
     * @param username
     * @param password
     * @return
     */
    @Override
    public String isAdmin(String username, String password) {
        AdminDto dto = new AdminDto();
        dto.setUsername(username);
        dto.setPassword(password);
        return adminMapper.findAdminByNameAndPwd(dto);
    }

    @Override
    public EmployeeDto isCommonUser(String username, String password) {
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setUsername(username);
        employeeDto.setPassword(password);
        EmployeeDto userByNameAndPwd = employeeMapper.findUserByNameAndPwd(employeeDto);
        return userByNameAndPwd;
    }
}
