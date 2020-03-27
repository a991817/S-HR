package com.dgut.shr.dto;

import lombok.Data;

import java.sql.Date;

@Data
public class EmployeeDto {
    private Long id;

    private String username;

    private String name;

    private String idNumber;

    private String password;

    private String gender;

    private String positionName;

    private String depName;

    private int department;

    private int position;

    private String wedlock;

    private int workState;

    private String email;

    private String phone;

    private String nativePlace;

    private Date birthday;

}
