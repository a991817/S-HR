package com.dgut.shr.service;

import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.EmployeeDto;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/9 14:12
 */
public interface AttendanceService {
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

    /**
     * 统计某个员工上个月出勤天数
     * @param dto
     * @return
     */
    int countEmpAttendance(AttendanceDto dto);


}
