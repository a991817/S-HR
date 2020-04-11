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
        return attendanceMapper.updateAttendance(dto);
    }

    @Override
    public AttendanceDto findByEmpIdAndDate(AttendanceDto dto) {
        return attendanceMapper.findByEmpIdAndDate(dto);
    }

}
