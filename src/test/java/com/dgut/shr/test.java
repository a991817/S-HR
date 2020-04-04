package com.dgut.shr;

import org.junit.Test;

import java.util.UUID;

/**
 * @author shijie_liu
 * @date 2020/4/4 15:40
 */
public class test {
    @Test
    public void test(){
        System.out.println(UUID.randomUUID().toString().replace("-", ""));
    }
}
