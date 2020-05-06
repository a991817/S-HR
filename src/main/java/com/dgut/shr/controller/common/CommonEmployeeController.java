package com.dgut.shr.controller.common;

import com.dgut.shr.config.Result;
import com.dgut.shr.controller.LoginController;
import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.dto.PasswordDto;
import com.dgut.shr.mapper.AttendanceMapper;
import com.dgut.shr.service.AttendanceService;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.sys.RedisService;
import com.dgut.shr.utils.CookieUtil;
import com.dgut.shr.vo.CurMonthAttendanceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        model.addAttribute("employee", employee);
//        把员工信息放在Model中
        return "page/common/employeeInfo";
    }

    /**
     * 用户首页内嵌的部分
     *
     * @return
     */
    @RequestMapping("/toCommonMain")
    public String toCommonMain(HttpServletRequest request, Model model) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (LoginController.TOKEN.equals(cookie.getName())) {
                    String empId = redisService.get(cookie.getValue());
                    EmployeeDto query = new EmployeeDto();
                    query.setId(Long.valueOf(empId));
//                    查找个人信息
                    EmployeeDto dto = employeeService.getEmployeeBy(query);
//                    查找领导
                    EmployeeDto leader = employeeService.getLeaderBy(dto);
//                    查找考勤信息
                    AttendanceDto attendance = getAttendanceInfo(empId);
//                    获取当月考勤
                    CurMonthAttendanceVo curMonthAttendance = attendanceService.getCurMonthAttendance(dto);
                    model.addAttribute("employee", dto);
                    model.addAttribute("leader", leader);
                    model.addAttribute("attendance", attendance);
                    model.addAttribute("curMonthAttendance", curMonthAttendance);
                    break;
                }
            }
        }
        return "page/common/main";
    }

    /**
     * 获取当天考勤信息
     *
     * @param empId
     * @return
     */
    public AttendanceDto getAttendanceInfo(String empId) {
        AttendanceDto queryAttendance = new AttendanceDto();
        queryAttendance.setEmployeeId(Long.valueOf(empId));
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        String today = df.format(new Date());// new Date()为获取当前系统时间
        queryAttendance.setDate(today);
        AttendanceDto attendance = attendanceService.findByEmpIdAndDate(queryAttendance);
        setSignState(attendance);
        if (attendance == null) {
            attendance = new AttendanceDto();
            attendance.setSignInState("未签到");
            attendance.setSignOutState("未签退");
        }
        return attendance;
    }

    /**
     * 设置考勤状态
     *
     * @param attendance
     */
    public void setSignState(AttendanceDto attendance) {
        if (attendance == null) {
            return;
        }
        Date signIn = new Date();
        Date signOut = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (!StringUtils.isEmpty(attendance.getSignInTime())) {
            try {
                signIn = sdf.parse(attendance.getSignInTime());
//                把时间改为时分
                attendance.setSignInTime(signIn.getHours() + ":" + signIn.getMinutes());
                int hours = signIn.getHours();
                //            迟到
                if (hours >= 8) {
                    attendance.setSignInState("迟到");
                } else {
                    attendance.setSignInState("准时");
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            attendance.setSignInState("未签到");
        }

        if (!StringUtils.isEmpty(attendance.getSignOutTime())) {
            try {
                signOut = sdf.parse(attendance.getSignOutTime());
                //                把时间改为时分
                attendance.setSignOutTime(signOut.getHours() + ":" + signOut.getMinutes());
                int hours = signOut.getHours();
//            迟到
                if (hours < 18) {
                    attendance.setSignOutState("早退");
                } else {
                    attendance.setSignOutState("准时");
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            attendance.setSignOutState("未签退");
        }

//        计算工作时长
        if (!StringUtils.isEmpty(attendance.getSignOutTime()) && !StringUtils.isEmpty(attendance.getSignInTime())) {
            int workHours = signOut.getHours() - signIn.getHours();
            attendance.setWorkHours(workHours);
        }
    }

    /**
     * 领导详细信息iframe
     *
     * @return
     */
    @RequestMapping("/leaderInfo")
    public String leaderInfo(HttpServletRequest request, Model model) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (LoginController.TOKEN.equals(cookie.getName())) {
                    String empId = redisService.get(cookie.getValue());
                    EmployeeDto query = new EmployeeDto();
                    query.setId(Long.valueOf(empId));
//                    查找个人信息
                    EmployeeDto dto = employeeService.getEmployeeBy(query);
                    //                    查找领导
                    EmployeeDto leader = employeeService.getLeaderBy(dto);
                    model.addAttribute("leader", leader);
                    break;
                }
            }
        }
        return "page/common/leaderInfo";
    }


    @RequestMapping("changePwdPage")
    public String changePwdPage() {
        return "page/common/changePwdPage";
    }


    @RequestMapping("changePwd")
    @ResponseBody
    public Result changePwd(PasswordDto dto, HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (LoginController.TOKEN.equals(cookie.getName())) {
                    dto.setEmployeeId(redisService.get(cookie.getValue()));
                    int cols = employeeService.changePwd(dto);
                    if (cols == -2) {
                        return Result.NEWPWD_NOTSAME;
                    } else if (cols == -3){
                        return Result.PWD_LENGHT_ERROR;
                    } if (cols <= 0) {
                        return Result.OLDPWD_FAIL;
                    }
                    return Result.CHANGEPWD_SUCCESS;
                }
            }
        }
        return Result.CHANGEPWD_FAIL;
    }

}
