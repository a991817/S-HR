package com.dgut.shr.controller.common;

import com.dgut.shr.config.Result;
import com.dgut.shr.controller.LoginController;
import com.dgut.shr.dto.AttendanceDto;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.AttendanceService;
import com.dgut.shr.service.sys.RedisService;
import com.dgut.shr.utils.CookieUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/9 14:14
 */
@Controller
@RequestMapping("attendance")
public class CommonAttendanceController {

    @Autowired
    RedisService redisService;
    @Autowired
    AttendanceService attendanceService;
    /**
     * 签到接口
     * @param request
     * @return
     */
    @RequestMapping("signIn")
    @ResponseBody
    public Result signIn(HttpServletRequest request){
//        获取token
        String token = CookieUtil.getCookieValue(request,LoginController.TOKEN);
//        从redis中获取用户Id
        String empId = redisService.get(token);
//        获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        Date date = new Date();
        String now = df.format(date);// new Date()为获取当前系统时间
//        保存一条签到的考勤信息
        AttendanceDto attendanceDto = new AttendanceDto();
        attendanceDto.setDate(now);
        attendanceDto.setEmployeeId(Long.valueOf(empId));
        attendanceDto.setSignInTime(now);
//      早退
        if (date.getHours() > 8){
            attendanceDto.setSignInState("1");
        }
        attendanceService.addAttendance(attendanceDto);
        attendanceDto.setSignInTime(date.getHours() + ":" + date.getMinutes());
        if (date.getHours() > 8){
            attendanceDto.setSignInState("迟到");
        }else{
            attendanceDto.setSignInState("正常");
        }
        return new Result("200","签到成功",attendanceDto);
    }

    /**
     * 签退接口
     * @param request
     * @return
     */
    @RequestMapping("signOut")
    @ResponseBody
    public Result signOut(HttpServletRequest request){
//        获取token
        String token = CookieUtil.getCookieValue(request,LoginController.TOKEN);

//        从redis中获取用户Id
        String empId = redisService.get(token);

//        获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        Date date = new Date();
        String now = df.format(date);// new Date()为获取当前系统时间

//        根据员工工号和时间查询该用户当天是否签到了，如果没有签到直接返回签退失败
        AttendanceDto attendanceDto = new AttendanceDto();
        attendanceDto.setEmployeeId(Long.valueOf(empId));
        attendanceDto.setDate(now);
        AttendanceDto old = attendanceService.findByEmpIdAndDate(attendanceDto);
        if(old == null){
            return Result.SIGN_IN_FAIL;
        }
//        保存一条签退的考勤信息
        old.setSignOutTime(now);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date signIn = null;

        try {
//            设置工作时长
            signIn = sdf.parse(old.getSignInTime());
            Date signOut = sdf.parse(old.getSignOutTime());
            int workHours = signOut.getHours() - signIn.getHours() ;
            old.setWorkHours(workHours);
//           设置加班时长，如果超过8小时就算加班
            if (workHours > 10){
                old.setOvertimeHours(workHours - 10);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
//        早退
        if (date.getHours() < 18){
            old.setSignOutState("1");
        }
        attendanceService.updateAttendance(old);
        old.setSignOutTime(date.getHours() + ":" + date.getMinutes());
        if (date.getHours() < 18){
            old.setSignOutState("早退");
        }else{
            old.setSignOutState("正常");
        }
        return new Result("200","签退成功",old);
    }

    @RequestMapping("attendanceList")
    public String attendanceList(){
        return "page/common/attendanceList";
    }

    @RequestMapping("attendanceInfo")
    @ResponseBody
    public PageResult attendanceInfo(@RequestParam(required = false,defaultValue = "1") int page,
                                     @RequestParam(required = false,defaultValue = "10") int limit,
                                     @RequestParam(required = false)String startTime,
                                     @RequestParam(required = false)String endTime,
                                     HttpServletRequest request){
        String token = CookieUtil.getCookieValue(request, LoginController.TOKEN);
        String empId = redisService.get(token);
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo= PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        AttendanceDto query = new AttendanceDto();
        query.setEmployeeId(Long.valueOf(empId));
        query.setStartTime(startTime);
        query.setEndTime(endTime);
        List<AttendanceDto> dtos = attendanceService.selectList(query);
//设置状态
        for (AttendanceDto dto : dtos) {
            String state = "";
            if ("1".equals(dto.getSignInState())){
                state = state + "迟到 ";
            }
            if ("1".equals(dto.getSignOutState())){
                state = state + "早退";
            }
            if (StringUtils.isEmpty(state)){
                state = "正常";
            }
            dto.setState(state);
        }
// 获取查询记录总数，必须位于从数据库查询数据的语句之后，否则不生效
        long total = pageInfo.getTotal();
        PageResult pageResult = new PageResult();
        pageResult.setCode(0);
        pageResult.setCount(total);
        pageResult.setMsg("msg");
        pageResult.setData(dtos);
        return pageResult;
    }
}
