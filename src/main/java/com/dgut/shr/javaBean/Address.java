package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author shijie_liu
 * @date 2020/4/4 16:51
 */
@Data
@TableName("tb_Address")
public class Address {
    private long employeeId;

    private String province;

    private String city;

    private String area;
}
