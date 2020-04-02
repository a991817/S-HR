package com.dgut.shr.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class DepartmentDto {
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
     *
     */
    private String leaderName;

    /**
     * 部门数量
     */
    private int numberOfPeople;

    /**
     * 部门员工
     */
    private List<EmployeeDto> employees;
}
