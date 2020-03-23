package com.dgut.shr.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;
import com.dgut.shr.mapper.EmployeeMapper;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    @RequestMapping("/su")
    public ModelAndView toSuccess(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("name","张三");
        modelAndView.setViewName("abc");
        return modelAndView;
    }

    @RequestMapping("/employeeList")
    public String employeeList(Model model){
//        List<Employee> employees = employeeMapper.selectList(null);
//        model.addAttribute("employees",employees);
        return "page/system/employeeList";
    }

    @RequestMapping("/employeeInfo")
    @ResponseBody
    public PageResult employeeInfo(@RequestParam(required = false,defaultValue = "1") int page,
                                   @RequestParam(required = false,defaultValue = "10") int limit){
        Page<Employee> pageInfo = new Page<>(page,limit);
//        IPage<Employee> employeeIPage = employeeService.selectPage(pageInfo, null);

        PageResult pageResult = new PageResult();
        pageResult.setCode(0);
        pageResult.setCount(employeeService.countAllEmployee());
        pageResult.setMsg("msg");
        pageResult.setData(employeeService.selectList(null));
        return pageResult;
    }


}
