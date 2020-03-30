package com.dgut.shr.dto;

import lombok.Data;

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
}
