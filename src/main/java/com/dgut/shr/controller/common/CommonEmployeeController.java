package com.dgut.shr.controller.common;

import com.dgut.shr.controller.LoginController;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.sys.RedisService;
import com.dgut.shr.utils.CookieUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author shijie_liu
 * @date 2020/4/3 15:15
 */
@Controller
@RequestMapping("common/employee")
public class CommonEmployeeController {

    @Autowired
    RedisService redisService;

    @Autowired
    EmployeeService employeeService;

    /**
     * 详细信息页面
     *
     * @param request
     * @return
     */
    @RequestMapping("employeeInfo")
    public String employeeInfo(HttpServletRequest request, Model model) {
//        在cookie中获得token
        String token = CookieUtil.getCookieValue(request, LoginController.TOKEN);
//        用token去redis中获取员工号
        String employeeId = redisService.get(token);
//        通过员工号查询员工的详细信息
        EmployeeDto dto = new EmployeeDto();
        dto.setId(Long.valueOf(employeeId));
        EmployeeDto employee = employeeService.getEmployeeBy(dto);
        model.addAttribute("employee",employee);
//        把员工信息放在Model中
        return "page/common/employeeInfo";
    }
}
