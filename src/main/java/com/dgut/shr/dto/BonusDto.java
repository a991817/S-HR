package com.dgut.shr.dto;

import lombok.Data;

import java.util.List;

/**
 * 从前端传过来的实体对象
 * @author shijie_liu
 * @date 2020/4/22 18:23
 */
@Data
public class BonusDto {

    String departmentId;

    /**
     * 奖金类型 1-年终奖 2-当月奖金
     */
    String type;

    String bonus;

    List<EmployeeDto> employeeList;

    String payYearMonth;
}
