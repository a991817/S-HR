package com.dgut.shr.controller;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.dto.PositionDto;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.DepartmentService;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.PositionService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    PositionService positionService;

    /**
     * 跳转到员工详情
     * @return
     */
    @RequestMapping("/employeeList")
    public String employeeList(){
        return "page/system/employeeList";
    }

    /**
     * 获取员工信息的json数据
     * @param page
     * @param limit
     * @param key
     * @param select
     * @return
     */
    @RequestMapping("/employeeInfo")
    @ResponseBody
    public PageResult employeeInfo(@RequestParam(required = false,defaultValue = "1") int page,
                                   @RequestParam(required = false,defaultValue = "10") int limit,
                                   @RequestParam(required = false) String key,
                                   @RequestParam(required = false) String select){
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo= PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        EmployeeDto employeeDto = new EmployeeDto();
        if ("1".equals(select)){
            employeeDto.setName(key);
        }
        if ("2".equals(select)){
            employeeDto.setDepName(key);
        }
        List<EmployeeDto> employees = employeeService.selectList(employeeDto);
// 获取查询记录总数，必须位于从数据库查询数据的语句之后，否则不生效
        long total = pageInfo.getTotal();
        PageResult pageResult = new PageResult();
        pageResult.setCode(0);
        pageResult.setCount(total);
        pageResult.setMsg("msg");
        pageResult.setData(employees);
        return pageResult;
    }

    /**
     * 跳转到添加员工界面
     * @return
     */
    @RequestMapping("employeeAddPage")
    public String employeeAddPage(Model model){
        List<DepartmentDto> departmentDtos = departmentService.selectList(new DepartmentDto());
        List<PositionDto> positionDtos = positionService.selectList(new PositionDto());
        model.addAttribute("departments",departmentDtos);
        model.addAttribute("positions",positionDtos);
        return "page/system/employeeAdd";
    }


    @RequestMapping("employeeAdd")
    @ResponseBody
    public Result employeeAdd(EmployeeDto employeeDto ,String submitType){
        if ("edit".equals(submitType)){
            int cols = employeeService.updateEmployee(employeeDto);
            if (cols > 0){
                return Result.UPDATE_EMPLOYEE_SUCCESS;
            }
            return Result.UPDATE_EMPLOYEE_FAIL;
        }
        //通过身份证判断是否已经存在
        if (StringUtils.isEmpty(employeeDto.getIdNumber())){
            return Result.INPUT_ARGS_ERROR;
        }
        if (employeeService.getEmployeeBy(employeeDto) != null){
            return Result.ADD_EMPLOYEE_REPEAT;
        }
        //如果不存在就新增
        employeeService.addEmployee(employeeDto);
        return Result.ADD_EMPLOYEE_SUCCESS;
    }

    @RequestMapping("getEmployeeById")
    @ResponseBody
    public Result getEmployeeById(EmployeeDto employeeDto){
        EmployeeDto employee = employeeService.getEmployeeBy(employeeDto);
        if (employee == null){
            return Result.NO_EMPLOYEE_ID;
        }
        Result result = Result.FIND_EMPLOYEE_SUCCESS;
        result.setData(employee);
        return result;
    }

    @RequestMapping("deleteEmployeeById")
    @ResponseBody
    public Result deleteEmployeeById(EmployeeDto employeeDto){
        int cols = employeeService.deleteEmployee(employeeDto);
        if (cols > 0){
            return Result.DELETE_EMPLOYEE_SUCCESS;
        }
        return Result.DELETE_EMPLOYEE_FAIL;
    }

    @RequestMapping("deleteEmployeeMany")
    @ResponseBody
    public Result deleteEmployeeById(@RequestParam(value="ids[]") String[] ids){
        int cols = employeeService.deleteEmployeeMany(ids);
        if (cols > 0){
            return Result.DELETE_EMPLOYEE_SUCCESS;
        }
        return Result.DELETE_EMPLOYEE_FAIL;
    }

}
