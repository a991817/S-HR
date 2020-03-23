package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("tb_employee")
public class Employee {
    private Long id;

    private String username;

    private String password;

    private int status;

    private Date hireDate;

    private String name;

    private Long departmentId;
}
