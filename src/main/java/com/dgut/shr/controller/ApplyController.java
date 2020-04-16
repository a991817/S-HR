package com.dgut.shr.controller;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.javaBean.Apply;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.ApplyService;
import com.dgut.shr.service.sys.RedisService;
import com.dgut.shr.utils.CookieUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.rmi.runtime.Log;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/11 17:33
 */
@Controller
@RequestMapping("apply")
public class ApplyController {
    @Autowired
    ApplyService applyService;

    @Autowired
    RedisService redisService;

    /**
     * 提交申请
     *
     * @param apply
     * @return
     */
    @RequestMapping("addApply")
    @ResponseBody
    public Result addApply(Apply apply, HttpServletRequest request) {
        if (apply == null) {
            return Result.APPLY_FAIL;
        }
        String empId = redisService.get(CookieUtil.getCookieValue(request, LoginController.TOKEN));
        apply.setEmployeeId(Long.valueOf(empId));
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        apply.setDate(df.format(new Date()));
//        先判断该员工当天是否已经申请了相同类型的申请
        if (applyService.selectList(apply).size() > 0) {
            return new Result("1", "您已提交过相同的申请了");
        }
        int cols = applyService.insertApply(apply);
        if (cols > 0) {
            return Result.APPLY_SUCCESS;
        }
        return Result.APPLY_FAIL;
    }

    /**
     * 审批申请
     * 前端只传申请id和state过来就可以了
     */
    @RequestMapping("approval")
    @ResponseBody
    public Result approval(Apply apply) {
        if (apply == null) {
            return Result.FAIL;
        }
        Apply res = applyService.getById(apply);
        res.setType(apply.getType());
        res.setState(apply.getState());
        res.setDate(apply.getDate());
        if (res == null){
            return Result.FAIL;
        }
//        判断是审批什么的，签到，签退，请假
        if (apply.getType() == 1 || apply.getType() == 2) {
//        签到或者签退补卡
            applyService.signInOrOutApply(res);
        }else if (apply.getState() == 3){
//        请假
            applyService.leaveApply(res);
        }
        return Result.SUCCESS;
    }

    /**
     * 管理员跳转到申请管理列表
     *
     * @return
     */
    @RequestMapping("applyList")
    public String applyList() {
        return "page/system/applyList";
    }

    /**
     * 管理员获取申请信息
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("applyInfo")
    @ResponseBody
    public PageResult applyInfo(@RequestParam(required = false, defaultValue = "1") int page,
                                @RequestParam(required = false, defaultValue = "10") int limit
    ) {
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo = PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        Apply query = new Apply();
        List<Apply> applies = applyService.selectList(query);
// 获取查询记录总数，必须位于从数据库查询数据的语句之后，否则不生效
        long total = pageInfo.getTotal();
        PageResult pageResult = new PageResult();
        pageResult.setCode(0);
        pageResult.setCount(total);
        pageResult.setMsg("msg");
        pageResult.setData(applies);
        return pageResult;
    }


}
