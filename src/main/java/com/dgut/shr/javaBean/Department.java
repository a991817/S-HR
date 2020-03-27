package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("tb_department")
public class Department {
    private long id;
    /**
     * 部门名称
     */
    private String depName;

    /**
     * 领导Id
     */
    private int leaderId;

    /**
     * 部门数量
     */
    private int numberOfPeople;
}
