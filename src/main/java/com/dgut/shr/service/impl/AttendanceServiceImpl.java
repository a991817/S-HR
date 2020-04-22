package com.dgut.shr.service.impl;

import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.mapper.AttendanceMapper;
import com.dgut.shr.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/9 14:13
 */
@Service("attendanceService")
public class AttendanceServiceImpl implements AttendanceService {
    @Autowired
    AttendanceMapper attendanceMapper;
    @Override
    public int countAllAttendance() {
        return attendanceMapper.countAllAttendance();
    }

    @Override
    public List<AttendanceDto> selectList(AttendanceDto dto) {
        return attendanceMapper.selectList(dto);
    }

    @Override
    public int addAttendance(AttendanceDto dto) {
        return attendanceMapper.addAttendance(dto);
    }

    @Override
    public int updateAttendance(AttendanceDto dto) {
//        如果设置了签到时间或者签退时间，那么就计算工作时间和加班时间
        if (!StringUtils.isEmpty(dto.getSignOutTime()) || !StringUtils.isEmpty(dto.getSignInTime())){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
//            设置工作时长
                Date signOut = sdf.parse(dto.getSignOutTime());
                Date signIn = sdf.parse(dto.getSignInTime());
                int workHours = signOut.getHours() - signIn.getHours();
                dto.setWorkHours(workHours);
//           设置加班时长，如果超过8小时就算加班
                if (workHours > 10){
                    dto.setOvertimeHours(workHours - 10);
                }else{
                    dto.setOvertimeHours(0);
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return attendanceMapper.updateAttendance(dto);
    }

    @Override
    public AttendanceDto findByEmpIdAndDate(AttendanceDto dto) {
        return attendanceMapper.findByEmpIdAndDate(dto);
    }

    @Override
    public int countEmpAttendance(AttendanceDto dto) {
        return attendanceMapper.countEmpAttendance(dto);
    }

}
