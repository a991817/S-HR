package com.dgut.shr.controller;

import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Apply;
import com.dgut.shr.service.ApplyService;
import com.dgut.shr.service.DepartmentService;
import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.sys.LoginService;
import com.dgut.shr.service.sys.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

@Controller
public class LoginController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    LoginService loginService;                    
    @Autowired
    RedisService redisService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    ApplyService applyService;
    public static final String TOKEN = "shr_token";

    private static final int COOKIE_MAX_AGE =  60*5     ;

    /**
     * 跳到登陆页面
     * @return
     */
    @RequestMapping("/login")
    public String loginPage(){
        return "page/login/login";
    }

    /**
     * 真正实施登陆
     * @param username
     * @param password
     * @param model
     * @param httpSession
     * @return
     */
    @RequestMapping("/doLogin")
    public String doLogin(String username , String password,String role, Model model, HttpSession httpSession, HttpServletResponse response){
        //其实username是邮箱
        String adminUserName = loginService.isAdmin(username, password,role);
        if (!StringUtils.isEmpty(adminUserName)) {
            //登陆成功
            model.addAttribute("username", adminUserName);
            httpSession.setAttribute("username","管理员");
            String token = createToken();
            Cookie cookie = new Cookie(TOKEN,token);
            cookie.setPath("/");
            cookie.setMaxAge(COOKIE_MAX_AGE);
            response.addCookie(cookie);
//            return "redirect:/index.html";
            return "index";
        }
        EmployeeDto commonUser = loginService.isCommonUser(username, password);
        if (commonUser != null){
            //登陆成功
            model.addAttribute("msg", "success");
            model.addAttribute("username", commonUser.getName());
            httpSession.setAttribute("username","1");
//           生成一个token,把token放在cookie中，并且以token:employeeId的形式放在redis中
            String token = createToken();
            Cookie cookie = new Cookie(TOKEN,token);
            cookie.setPath("/");
            cookie.setMaxAge(COOKIE_MAX_AGE);
            response.addCookie(cookie);
            redisService.set(token, String.valueOf(commonUser.getId()),COOKIE_MAX_AGE);
//            return "redirect:/index.html";
            return "page/common/index";
        }
        else{
            //登陆失败
            model.addAttribute("msg", "fail");
            return "page/login/login";
        }
    }

    /**
     * 首页内嵌的部分
     * @return
     */
    @RequestMapping("/toMain")
    public String toMain(Model model){
        EmployeeDto employeeDto = new EmployeeDto();
//        在职
        employeeDto.setWorkState(1);
        int empNums = employeeService.countAllEmployee(employeeDto);
        int depNums = departmentService.countDepartment();
        int applyAll = applyService.countApply(new Apply());
        Apply queryApply = new Apply();
//        未审批
        queryApply.setState(0);
        int applyNotApproved = applyService.countApply(queryApply);
        model.addAttribute("empNums",empNums);
        model.addAttribute("depNums",depNums);
        model.addAttribute("applyAll",applyAll);
        model.addAttribute("applyNotApproved",applyNotApproved);
        return "page/main";
    }



    /**
     * 注销
     * @param session
     * @return
     */
    @RequestMapping("/logOut")
    public String logOut(HttpSession session, HttpServletRequest request,HttpServletResponse response){
        session.removeAttribute("username");
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (TOKEN.equals(cookie.getName())) {
//                删除redis
                    redisService.delete(cookie.getValue());
//                删除cookie
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        return "redirect:/login";
    }

    private String createToken(){
        return UUID.randomUUID().toString().replace("-","");
    }
}
