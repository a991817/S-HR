package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.javaBean.Address;
import com.dgut.shr.javaBean.Salary;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author shijie_liu
 * @date 2020/4/22 22:48
 */
@Mapper
public interface SalaryMapper extends BaseMapper<Address> {
    int insert(Salary salary);
}
