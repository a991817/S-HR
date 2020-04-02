package com.dgut.shr.dto;

import com.dgut.shr.javaBean.Position;
import lombok.Data;

/**
 * @author shijie_liu
 * @date 2020/3/27 15:01
 */
@Data
public class PositionDto  {
    private long id;

    private String positionName;

    private int numberOfEmployee;
}
