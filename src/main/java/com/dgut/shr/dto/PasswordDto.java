package com.dgut.shr.dto;

import lombok.Data;

/**
 * @author shijie_liu
 * @date 2020/5/6 18:34
 */
@Data
public class PasswordDto {
    String employeeId;

    String newPassword;

    String oldPassword;

    String newPassword1;
}
