package com.dgut.shr;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;
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

    @Test
    public void test2(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        System.out.println(df.format(new Date()));
    }
}
