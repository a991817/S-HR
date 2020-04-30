package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Address;
import com.dgut.shr.javaBean.Apply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/4 17:18
 */
@Mapper
public interface ApplyMapper extends BaseMapper<Apply> {

    /**
     * 插入一个申请记录
     * @param apply
     * @return
     */
    int insertApply(Apply apply);

    /**
     * 更新一个申请记录
     * @param apply
     * @return
     */
    int updateApply(Apply apply);

    /**
     * 查询所有申请记录
     * @param apply
     * @return
     */
    List<Apply> selectList(Apply apply);

    /**
     * 通过id查询员工Id
     * @param apply
     * @return
     */
    String selectEmpIdById(Apply apply);

    /**
     * 通过id查询某条申请
     * @param apply
     * @return
     */
    Apply getById(Apply apply);

    int countApply(Apply apply);

}
