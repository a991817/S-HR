package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.AdminDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper extends BaseMapper {
    /**
     * 通过用户名和密码判断是不是管理员
     * @param dto
     * @return
     */
    String findAdminByNameAndPwd(AdminDto dto);
}
