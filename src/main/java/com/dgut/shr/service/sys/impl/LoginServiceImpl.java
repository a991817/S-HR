package com.dgut.shr.service.sys.impl;

import com.dgut.shr.mapper.AdminMapper;
import com.dgut.shr.service.sys.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    AdminMapper adminMapper;

    /**
     * 通过用户名和密码判断是不是管理员
     * @param username
     * @param password
     * @return
     */
    @Override
    public boolean isAdmin(String username, String password) {
        String res = adminMapper.findAdminByNameAndPwd(username, password);
        if (res == null){
            return false;
        }
        return true;
    }
}
