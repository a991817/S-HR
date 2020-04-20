package com.dgut.shr.service.impl;

import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Apply;
import com.dgut.shr.mapper.ApplyMapper;
import com.dgut.shr.service.ApplyService;
import com.dgut.shr.service.AttendanceService;
import com.dgut.shr.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/11 17:29
 */
@Service("applyService")
public class ApplyServiceImpl implements ApplyService {

    @Autowired
    ApplyMapper applyMapper;
    @Autowired
    AttendanceService attendanceService;
    @Autowired
    EmployeeService employeeService;

    @Override
    public int insertApply(Apply apply) {
        return applyMapper.insertApply(apply);
    }

    @Override
    public int updateApply(Apply apply) {
        return applyMapper.updateApply(apply);
    }

    @Override
    public List<Apply> selectList(Apply apply) {
        return applyMapper.selectList(apply);
    }

    @Override
    public int signInOrOutApply(Apply apply) {
//        签到补卡-迟到补卡
//        如果状态是拒绝通过，直接改申请表里的状态未审批未通过
        if (apply.getState() == 2) {
            return applyMapper.updateApply(apply);
        }
//        状态时通过
//        出勤表：把签到时间改成当天的8点，迟到状态改为0-正常
        AttendanceDto dto = new AttendanceDto();
        dto.setEmployeeId(apply.getEmployeeId());
        dto.setDate(apply.getStartTime());
//        获得那天的考勤记录
        AttendanceDto attendance = attendanceService.selectList(dto).get(0);
        try {
//            把时间改为8点
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = sdf.parse(attendance.getSignInTime());
            if (apply.getType() == 1){
                date.setHours(8);
                date.setMinutes(0);
                date.setSeconds(0);
                dto.setSignInTime(sdf.format(date));
                dto.setSignOutTime(attendance.getSignOutTime());
                dto.setSignInState("0");
                apply.setStartTime(dto.getSignInTime());
                apply.setEndTime(dto.getSignInTime());
            }else{
                date.setHours(18);
                date.setMinutes(0);
                date.setSeconds(0);
                dto.setSignInTime(attendance.getSignInTime());
                dto.setSignOutTime(sdf.format(date));
                dto.setSignOutState("0");
                apply.setStartTime(dto.getSignOutTime());
                apply.setEndTime(dto.getSignOutTime());
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        attendanceService.updateAttendance(dto);
//        申请表：状态改为审批通过
        return applyMapper.updateApply(apply);
    }

    @Override
    public int leaveApply(Apply apply) {
        return applyMapper.updateApply(apply);
    }

    @Override
    public String selectEmpIdById(Apply apply) {
        return applyMapper.selectEmpIdById(apply);
    }

    @Override
    public Apply getById(Apply apply) {
        return applyMapper.getById(apply);
    }

    @Override
    public int quitApply(Apply apply) {
//        把员工状态改为离职
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setId(apply.getEmployeeId());
        employeeDto.setWorkState(0);
        employeeService.updateEmployee(employeeDto);
//        更新申请状态
        return applyMapper.updateApply(apply);
    }
}
