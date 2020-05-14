package com.dgut.shr.service.impl;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.BonusDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Salary;
import com.dgut.shr.mapper.SalaryMapper;
import com.dgut.shr.service.AttendanceService;
import com.dgut.shr.service.BonusService;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/22 21:51
 */
@Service("salaryService")
public class SalaryServiceImpl implements SalaryService {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    AttendanceService attendanceService;
    @Autowired
    BonusService bonusService;
    @Autowired
    SalaryMapper salaryMapper;

    /**
     * 计算工资
     * 计算方法：基本月薪*（出勤天数/应出勤天数）+员工奖金+部门奖金
     * @return
     */
    @Override
    public Result calculateSalary() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//        上一个月
        Date date = new Date();
//        date.setMonth(4);
        if (date.getMonth() == 0){
            date.setMonth(11);
            date.setYear(date.getYear() - 1);
        }else{
            date.setMonth(date.getMonth() - 1);
        }
//        获取员工信息，获取基本工资
        EmployeeDto employeeDto1 = new EmployeeDto();
//        employeeDto1.setName("张三3");
        List<EmployeeDto> employeeList = employeeService.selectList(employeeDto1);
//        查找奖金
        for (EmployeeDto employeeDto : employeeList) {
            String lastDate = sdf.format(date);
//            计算工资的时候，要判断员工是不是上个月入职的
            double basicSalary = employeeDto.getBasicSalary();
            AttendanceDto attendanceDto = new AttendanceDto();
            attendanceDto.setEmployeeId(employeeDto.getId());
            attendanceDto.setDate(lastDate);
//            出勤天数
            double attendanceDays = attendanceService.countEmpAttendance(attendanceDto);
//            应出勤天数
            double shouldAttendanceDays = getWorkDays(date.getYear(),date.getMonth());
//            获取奖金
            BonusDto bonusDto = new BonusDto();
            bonusDto.setPayYearMonth(lastDate);
            bonusDto.setEmployeeId(String.valueOf(employeeDto.getId()));
//            如果不是12月，则不计算年终奖
            if (date.getMonth() != 11){
                bonusDto.setType("2");
            }
//            计算奖金
            double bonus = calculateBonus(bonusService.selectBonus(bonusDto),basicSalary);
            Salary salaryDto = new Salary();
            salaryDto.setEmployeeId(String.valueOf(employeeDto.getId()));
            salaryDto.setSalary(basicSalary + bonus );
            salaryDto.setRealSalary(basicSalary * (attendanceDays/shouldAttendanceDays) + bonus);
            salaryDto.setPayYearMonth(lastDate);
            salaryMapper.insert(salaryDto);
        }
        return null;
    }

    private double calculateWorkOverSalary(int workHours,double workDaySalary) {
        int wos = salaryMapper.getWorkOverSalary();
        return workHours/8 * wos * workDaySalary;
    }

    @Override
    public List<Salary> getSalaryByEmp(EmployeeDto dto) {
        return salaryMapper.getSalaryByEmp(dto);
    }

    /**
     * 计算奖金
     * @param bonus
     * @return
     */
    private double calculateBonus(List<BonusDto> bonus,double basicSalary){
        double yearFinalBonus = 0;
        double monthBonus = 0;
        for (BonusDto b : bonus) {
//            年终奖
            if ("1".equals(b.getType())){
                yearFinalBonus = basicSalary * b.getBonus();
            }
            if ("2".equals(b.getType())){
                monthBonus = monthBonus + b.getBonus();
            }
        }
        return yearFinalBonus + monthBonus;
    }

    /**
     * 计算某一个月的工作日有多少天
     * @param theYear
     * @param theMonth
     * @return
     */
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
