package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

/**
 * @author shijie_liu
 * @date 2020/4/11 17:20
 */
@Data
@TableName("tb_apply")
public class Apply {
    /**
     * 申请ID
     */
    private Long id;
    /**
     * 员工工号
     */
    private Long employeeId;

    /**
     * 员工姓名
     */
    private String name;

    /**
     * 申请状态 1-签到补卡 2-签退补卡 3-请假
     */
    private Integer type;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 是否解决 0-未解决 1-通过 2-未通过
     */
    private Integer state;

    /**
     * 申请日期
     */
    private String date;

    /**
     * 请假开始时间
     */
    private String startTime;

    /**
     * 请假结束时间
     */
    private String endTime;
}
