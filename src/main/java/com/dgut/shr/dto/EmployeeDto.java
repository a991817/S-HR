package com.dgut.shr.dto;

import lombok.Data;

import java.sql.Date;

@Data
public class EmployeeDto {
    private Long id;

    private String username;

    private String name;

    private String password;

    private int sex;

    private String positionName;

    private String depName;

    private Date hireDate;

    private int status;

}
