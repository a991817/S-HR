package com.dgut.shr;

import org.junit.Test;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author shijie_liu
 * @date 2020/4/4 15:40
 */
public class test {
    @Test
    public void test() {
        System.out.println(UUID.randomUUID().toString().replace("-", ""));
    }

    @Test
    public void test2() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        System.out.println(df.format(new Date()));
    }

    /**
     * <p>Title: main </P>
     * <p>Description: TODO </P>
     * return void    返回类型
     * throws
     * date 2014-11-24 上午09:11:47
     */
    @Test
    public void test3() {
        System.out.println(getWorkDays(2020, 4));
    }
    private static int getWorkDays(int theYear, int theMonth) {
        // 计算指定月有多少工作日
        int workDays = 0;
        Calendar cal = Calendar.getInstance();
        cal.set(theYear, theMonth - 1, 1);// 从每月1号开始
        int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        for (int i = 0; i < days; i++) {
            int day = cal.get(Calendar.DAY_OF_WEEK);
            if (!(day == Calendar.SUNDAY || day == Calendar.SATURDAY)) {
                workDays++;
            }
            cal.add(Calendar.DATE, 1);
        }
        return workDays;
    }


}