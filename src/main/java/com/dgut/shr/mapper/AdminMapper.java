package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

public interface AdminMapper extends BaseMapper {
    /**
     * 通过用户名和密码判断是不是管理员
     * @param username
     * @param password
     * @return
     */
    String findAdminByNameAndPwd(String username,String password);
}
