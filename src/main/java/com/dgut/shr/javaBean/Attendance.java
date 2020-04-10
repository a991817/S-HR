package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

/**
 * @author shijie_liu
 * @date 2020/4/9 10:54
 */
@Data
@TableName("tb_attendance")
public class Attendance {
    private Long id;

    private Long employeeId;

    private Date date;

    private Date signInTime;

    private Date signOutTime;

    private int workHours;

    private int overtimeHours;

    private int state;
}
