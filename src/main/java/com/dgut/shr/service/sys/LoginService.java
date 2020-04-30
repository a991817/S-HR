package com.dgut.shr.service.sys;

import com.dgut.shr.dto.EmployeeDto;

public interface LoginService {
    String isAdmin(String username,String password,String role);

    /**
     * 判断是否是合法的用户,返回用户姓名
     * @param username
     * @param password
     * @return
     */
    EmployeeDto isCommonUser(String username, String password);

}
