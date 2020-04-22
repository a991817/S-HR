package com.dgut.shr.dto;

import com.dgut.shr.javaBean.Address;
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

    private Long departmentId;

    private int positionId;

    private String wedlock;

    private int workState;

    private String email;

    private String phone;

    private String nativePlace;

    private Date birthday;

    private String tiptopDegree;

    private String school;

    private Date beginDate;

    private Address address;

    private double basicSalary;

}
