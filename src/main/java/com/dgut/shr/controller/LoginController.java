package com.dgut.shr.controller;

import com.dgut.shr.service.EmployeeService;
import com.dgut.shr.service.sys.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    LoginService loginService;

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
    public String login(String username , String password, Model model, HttpSession httpSession){
        //其实username是邮箱
        String adminUserName = loginService.isAdmin(username, password);
        if (!StringUtils.isEmpty(adminUserName)) {
            //登陆成功
            model.addAttribute("msg", "success");
            model.addAttribute("username", "管理员");
            httpSession.setAttribute("username","管理员");
//            return "redirect:/index.html";
            return "index";
        }else{
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
    public String toMain(){
        return "page/main";
    }

    /**
     * 注销
     * @param session
     * @return
     */
    @RequestMapping("/logOut")
    public String logOut(HttpSession session){
        session.removeAttribute("username");
        return "redirect:/login";
    }
}
