package com.dgut.shr.dto;

import lombok.Data;

/**
 * @author shijie_liu
 * @date 2020/4/9 10:56
 */
@Data
public class AttendanceDto {
    private Long id;

    private Long employeeId;

    private String date;

    private String signInTime;

    private String signOutTime;

    private int workHours;

    private int overtimeHours;

    private String state;

    private String signInState;

    private String signOutState;

    private String startTime;

    private String endTime;

    private int numberOfAttendance;

    private int exceptions;
}
