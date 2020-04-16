package com.dgut.shr.controller.common;

import com.dgut.shr.controller.LoginController;
import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.mapper.AttendanceMapper;
import com.dgut.shr.service.AttendanceService;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.sys.RedisService;
import com.dgut.shr.utils.CookieUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

    @Autowired
    AttendanceService attendanceService;

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

    /**
     * 用户首页内嵌的部分
     * @return
     */
    @RequestMapping("/toCommonMain")
    public String toCommonMain(HttpServletRequest request,Model model){
        Cookie[] cookies = request.getCookies();
        if (cookies != null){
            for (Cookie cookie : cookies) {
                if (LoginController.TOKEN.equals(cookie.getName())) {
                    String empId = redisService.get(cookie.getValue());
                    EmployeeDto query = new EmployeeDto();
                    query.setId(Long.valueOf(empId));
                    EmployeeDto dto = employeeService.getEmployeeBy(query);

                    AttendanceDto queryAttendance = new AttendanceDto();
                    queryAttendance.setEmployeeId(Long.valueOf(empId));
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
                    String today = df.format(new Date());// new Date()为获取当前系统时间
                    queryAttendance.setDate(today);
                    AttendanceDto attendance = attendanceService.findByEmpIdAndDate(queryAttendance);
                    setSignState(attendance);
                    if (attendance == null){
                        attendance = new AttendanceDto();
                        attendance.setSignInState("未签到");
                        attendance.setSignOutState("未签退");
                    }
                    model.addAttribute("employee",dto);
                    model.addAttribute("attendance",attendance);
                    break;
                }
            }
        }
        return "page/common/main";
    }

    public void setSignState(AttendanceDto attendance){
        if (attendance == null){
            return;
        }
        Date signIn = new Date();
        Date signOut = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (!StringUtils.isEmpty(attendance.getSignInTime())) {
            try {
                signIn = sdf.parse(attendance.getSignInTime());
//                把时间改为时分
                attendance.setSignInTime(signIn.getHours()+":"+signIn.getMinutes());
                int hours = signIn.getHours();
                //            迟到
                if (hours >= 8){
                    attendance.setSignInState("迟到");
                }else{
                    attendance.setSignInState("准时");
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }else{
            attendance.setSignInState("未签到");
        }

        if (!StringUtils.isEmpty(attendance.getSignOutTime())) {
            try {
                signOut = sdf.parse(attendance.getSignOutTime());
                //                把时间改为时分
                attendance.setSignOutTime(signOut.getHours()+":"+signOut.getMinutes());
                int hours = signOut.getHours();
//            迟到
                if (hours < 18){
                    attendance.setSignOutState("早退");
                }else{
                    attendance.setSignOutState("准时");
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }else{
            attendance.setSignOutState("未签退");
        }

//        计算工作时长
        if (!StringUtils.isEmpty(attendance.getSignOutTime()) && !StringUtils.isEmpty(attendance.getSignInTime())){
            int workHours = signOut.getHours() - signIn.getHours() ;
            attendance.setWorkHours(workHours);
        }
    }

}
