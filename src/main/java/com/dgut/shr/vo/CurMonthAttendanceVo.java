package com.dgut.shr.vo;

import lombok.Data;

/**
 * @author shijie_liu
 * @date 2020/4/30 15:36
 */
@Data
public class CurMonthAttendanceVo {

    /**
     * 工作小时
     */
    private int workHours;

    /**
     * 加班小时
     */
    private int overtimeHours;

    /**
     * 出勤天数
     */
    private int workDays;

    /**
     * 缺勤天数
     */
    private int notWorkDays;

    /**
     * 异常数
     */
    private int exceptions;
}
