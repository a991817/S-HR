package com.dgut.shr.dto;

import lombok.Data;

import java.sql.Date;

@Data
public class EmployeeDto {
    private Long id;

    private String username;

    private String name;

    private String password;

    private String gender;

    private String positionName;

    private String depName;

    private Date hireDate;

    private int workState;

    private String email;

    private String phone;

}
