package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 岗位
 */
@Data
@TableName("tb_position")
public class Position {
    private long id;

    private String positionName;
}
