package com.dgut.shr.utils;

import java.util.Calendar;

/**
 * @author shijie_liu
 * @date 2020/4/30 15:51
 */
public class WorkDaysUtil {

    /**
     * 计算从1号到end号的工作日
     * @param theYear
     * @param theMonth
     * @param end
     * @return
     */
    public static int getWorkDays(int theYear, int theMonth,int end) {
        // 计算指定月有多少工作日
        int workDays = 0;
        Calendar cal = Calendar.getInstance();
        cal.set(theYear, theMonth - 1, 1);
//        int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        for (int i = 0; i < end; i++) {
            int day = cal.get(Calendar.DAY_OF_WEEK);
            if (!(day == Calendar.SUNDAY || day == Calendar.SATURDAY)) {
                workDays++;
            }
            cal.add(Calendar.DATE, 1);
        }
        return workDays;
    }
}
