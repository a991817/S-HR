package com.dgut.shr;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.dgut.shr.mapper")
public class ShrApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShrApplication.class, args);
    }

}
