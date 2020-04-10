package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AttendanceMapper extends BaseMapper<Employee> {
    /**
     * 查询所有考勤信息的数量
     * @return
     */
    int countAllAttendance();

    /**
     * 查询所有考勤信息信息
     * @param dto
     * @return
     */
    List<AttendanceDto> selectList(AttendanceDto dto);

    /**
     * 新增一条考勤信息
     * @param dto
     * @return
     */
    int addAttendance(AttendanceDto dto);

    /**
     * 更新一个条考勤信息
     * @param dto
     * @return
     */
    int updateAttendance(AttendanceDto dto);

    /**
     * 查询指定日期某个员工是否签到了
     * @param dto
     * @return
     */
    AttendanceDto findByEmpIdAndDate(AttendanceDto dto);

}
