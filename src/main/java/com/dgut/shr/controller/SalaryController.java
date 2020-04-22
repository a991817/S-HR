package com.dgut.shr.controller;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.BonusDto;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.service.BonusService;
import com.dgut.shr.service.DepartmentService;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/21 17:28
 */
@Controller
@RequestMapping("salary")
public class SalaryController {
    private static final String WORK_OVER = "work_hour";
    @Autowired
    DepartmentService departmentService;
    @Autowired
    EmployeeService employeeService;
    @Autowired
    SettingService settingService;
    @Autowired
    BonusService bonusService;
    @RequestMapping("salarySettingPage")
    public String salarySetting(Model model){
        List<DepartmentDto> deps = departmentService.selectList(new DepartmentDto());
        String workOver = settingService.getValue(WORK_OVER);
        model.addAttribute("departments",deps);
        model.addAttribute("workOver",workOver);
        return "page/system/salarySetting";
    }

    @RequestMapping("workOverTimeSetting")
    @ResponseBody
    public Result workHourSetting(String number){
        if (StringUtils.isEmpty(number)){
            return new Result("1","加班工资不能为空");
        }
        if (StringUtils.isEmpty(settingService.getValue(WORK_OVER))){
            settingService.insert(WORK_OVER,number);
        }else{
            settingService.update(WORK_OVER,number);
        }
        return new Result("2","加班工资设置成功");
    }

    /**
     * 部门奖金设置
     * @param dto
     * @return
     */
    @RequestMapping("depBonusSetting")
    @ResponseBody
    public Result depBonusSetting(BonusDto dto){
//        获取该部门所有员工
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setDepartmentId(Long.valueOf(dto.getDepartmentId()));
        List<EmployeeDto> employeeList = employeeService.selectEmpIdList(employeeDto);
//        为每一个员工单独设置奖金
        dto.setIds(getIds(employeeList));
        int rows = bonusService.insertBatch(dto);
        if (rows > 0){
            return new Result("2","奖金设置成功");
        }else {
            return new Result("1","奖金设置失败");
        }
    }

    public List<String> getIds(List<EmployeeDto> employeeList){
        List<String> ids = new ArrayList<>();
        for (EmployeeDto employeeDto : employeeList) {
            ids.add(String.valueOf(employeeDto.getId()));
        }
        return ids;
    }

    /**
     * 员工奖金设置
     * @param ids
     * @param bonus
     * @return
     */
    @RequestMapping("empBonusSetting")
    @ResponseBody
    public Result empBonusSetting(@RequestParam(value="ids[]") String[] ids,String bonus){
        if (ids == null || ids.length <= 0 || StringUtils.isEmpty(bonus)){
            return new Result("1","奖金参数错误");
        }
        int rows = bonusService.insertBatch(ids, bonus);
        if (rows > 0){
            return new Result("2","奖金设置成功");
        }else {
            return new Result("1","奖金设置失败");
        }
    }

    /**
     * 计算工资
     * @return
     */
    @RequestMapping("calculateSalary")
    @ResponseBody
    public Result calculateSalary(){
//        计算方法：基本月薪+员工奖金+部门奖金-缺勤天数*（基本工资/一个月的工作日）
        return null;
    }
}
