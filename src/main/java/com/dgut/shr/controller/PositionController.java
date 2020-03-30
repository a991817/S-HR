package com.dgut.shr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author shijie_liu
 * @date 2020/3/30 15:03
 */
@Controller
public class PositionController {
    /**
     * 跳转到部门详情
     * @return
     */
    @RequestMapping("/positionList")
    public String employeeList(){
        return "page/system/positionList";
    }
}
