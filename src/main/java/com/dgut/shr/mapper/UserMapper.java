package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.UserDto;
import com.dgut.shr.javaBean.User;

public interface UserMapper extends BaseMapper<User> {
    User findUserByNameAndPwd(UserDto userDto);
}
