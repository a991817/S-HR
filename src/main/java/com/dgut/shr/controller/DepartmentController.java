package com.dgut.shr.controller;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.dto.PositionDto;
import com.dgut.shr.javaBean.Employee;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.DepartmentService;
import com.dgut.shr.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/3/30 14:54
 */
@Controller
@RequestMapping("department")
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    @Autowired
    EmployeeService employeeService;
    /**
     * 跳转到部门详情
     * @return
     */
    @RequestMapping("/departmentList")
    public String departmentList(){
        return "page/system/departmentList";
    }

    /**
     * 获取部门信息的json数据
     * @param page
     * @param limit
     * @param depName
     * @return
     */
    @RequestMapping("/departmentInfo")
    @ResponseBody
    public PageResult departmentInfo(@RequestParam(required = false,defaultValue = "1") int page,
                                   @RequestParam(required = false,defaultValue = "10") int limit,
                                   @RequestParam(required = false) String depName){
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo= PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        DepartmentDto departmentDto = new DepartmentDto();
        departmentDto.setDepName(depName);
        List<DepartmentDto> dtos = departmentService.selectDepInfo(departmentDto);
// 获取查询记录总数，必须位于从数据库查询数据的语句之后，否则不生效
        long total = pageInfo.getTotal();
        PageResult pageResult = new PageResult();
        pageResult.setCode(0);
        pageResult.setCount(total);
        pageResult.setMsg("msg");
        pageResult.setData(dtos);
        return pageResult;
    }

    /**
     * 跳转到添加部门界面
     * @return
     */
    @RequestMapping("departmentAddPage/{id}")
    public String departmentAddPage(@PathVariable(name = "id") long id,Model model){
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setDepartmentId(id);
        List<EmployeeDto> employeeDtos = employeeService.selectList(employeeDto);
        model.addAttribute("employees",employeeDtos);
        return "page/system/departmentAdd";
    }

    /**
     * 添加部门
     * @param departmentDto
     * @param submitType
     * @return
     */
    @RequestMapping("departmentAdd")
    @ResponseBody
    public Result departmentAdd(DepartmentDto departmentDto , String submitType){
        //编辑
        if ("edit".equals(submitType)){
            int cols = departmentService.updateDepartment(departmentDto);
            if (cols > 0){
                return Result.UPDATE_DEPARTMENT_SUCCESS;
            }
            return Result.UPDATE_DEPARTMENT_FAIL;
        }
        //通过部门名称判断是否重复
        if (StringUtils.isEmpty(departmentDto.getDepName())){
            return Result.INPUT_ARGS_ERROR;
        }
        if (departmentService.getDepartmentBy(departmentDto) != null){
            return Result.ADD_DEPARTMENT_REPEAT;
        }
        //如果不存在就新增
        departmentService.addDepartment(departmentDto);
        return Result.ADD_DEPARTMENT_SUCCESS;
    }

    @RequestMapping("deleteDepartmentById")
    @ResponseBody
    public Result deleteDepartmentById(DepartmentDto dto){
        int cols = departmentService.deleteDepartment(dto);
        if (cols > 0){
            return Result.DELETE_DEPARTMENT_SUCCESS;
        }
        return Result.DELETE_DEPARTMENT_FAIL;
    }

    @RequestMapping("deleteDepartmentMany")
    @ResponseBody
    public Result deleteDepartmentMany(@RequestParam(value="ids[]") String[] ids){
        int cols = departmentService.deleteDepartmentMany(ids);
        if (cols > 0){
            return Result.DELETE_DEPARTMENT_SUCCESS;
        }
        return Result.DELETE_DEPARTMENT_FAIL;
    }

    @RequestMapping("getDepartmentById")
    @ResponseBody
    public Result getDepartmentById(DepartmentDto dto){
//        查询部门信息
        DepartmentDto departmentDto = departmentService.getDepartmentBy(dto);
        if (departmentDto == null){
            return Result.NO_DEPARTMENT_ID;
        }
//        查询部门内的员工信息
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setDepartmentId(dto.getId());
        List<EmployeeDto> employeeDtos = employeeService.selectList(employeeDto);
        departmentDto.setEmployees(employeeDtos);

        Result result = Result.FIND_DEPARTMENT_SUCCESS;
        result.setData(departmentDto);
        return result;
    }

}
