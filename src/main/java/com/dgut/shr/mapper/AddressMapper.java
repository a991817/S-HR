package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Address;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/4 17:18
 */
@Mapper
public interface AddressMapper extends BaseMapper<Address> {
    /**
     * 根据员工号查询地址
     * @param dto
     * @return
     */
    Address getAddressByEmpId(EmployeeDto dto);

    /**
     * 插入一个地址
     * @param dto
     * @return
     */
    int insertAddress(EmployeeDto dto);

    /**
     * 编辑地址
     * @param dto
     * @return
     */
    int updateAddress(EmployeeDto dto);

    /**
     * 删除地址
     * @param dto
     * @return
     */
    int deleteAddress(EmployeeDto dto);
}
