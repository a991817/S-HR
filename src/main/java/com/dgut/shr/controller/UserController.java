package com.dgut.shr.controller;

import com.dgut.shr.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class UserController {

    @Autowired
    UserMapper userMapper;
    @RequestMapping("/su")
    public ModelAndView toSuccess(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("name","张三");
        modelAndView.setViewName("abc");
        return modelAndView;
    }
}
