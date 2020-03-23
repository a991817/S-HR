package com.dgut.shr.service.impl;

import com.dgut.shr.dto.UserDto;
import com.dgut.shr.javaBean.User;
import com.dgut.shr.mapper.UserMapper;
import com.dgut.shr.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.text.normalizer.UnicodeSet;

@Service("UserService")
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
    @Override
    public boolean existUserByUP(String username, String password) {
        UserDto userDto = new UserDto();
        userDto.setUsername(username);
        userDto.setPassword(password);
        User userByNameAndPwd = userMapper.findUserByNameAndPwd(userDto);
        if (userByNameAndPwd != null){
            return true;
        }
        return false;
    }
}
