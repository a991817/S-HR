package com.dgut.shr.javaBean;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("tb_user")
public class User {
    private Long id;
    private String username;
    private String password;
}
