package com.dgut.shr.controller.common;

import com.dgut.shr.config.Result;
import com.dgut.shr.controller.LoginController;
import com.dgut.shr.javaBean.Apply;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.ApplyService;
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
 * @date 2020/4/20 14:42
 */
@Controller
@RequestMapping("/commonApply")
public class CommonApplyController {
    @Autowired
    ApplyService applyService;

    @Autowired
    RedisService redisService;

    /**
     * 提交申请(迟到，早退的补卡申请）
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
     * 跳转到请假申请页面
     * @return
     */
    @RequestMapping("leavePage")
    public String leavePage(){
        return "page/common/leaveAdd";
    }

    /**
     * 跳转到离职申请页面
     * @return
     */
    @RequestMapping("quitPage")
    public String quitPage(){
        return "page/common/quitAdd";
    }

    /**
     * 请假申请
     * @return
     */
    @RequestMapping("addLeaveApply")
    @ResponseBody
    public Result addLeaveApply(Apply apply, HttpServletRequest request){
        if (apply == null) {
            return Result.APPLY_FAIL;
        }
        try {
            SimpleDateFormat dateDf = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
//            如果开始时间晚于结束时间的话返回错误i西南西
            if (dateDf.parse(apply.getEndTime()).before(dateDf.parse(apply.getStartTime()))){
                return new Result("1","开始日期不能晚于结束日期！");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String empId = redisService.get(CookieUtil.getCookieValue(request, LoginController.TOKEN));
//        设置当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        apply.setEmployeeId(Long.valueOf(empId));
        apply.setDate(df.format(new Date()));
        int cols = applyService.insertApply(apply);
        if (cols > 0) {
            return Result.APPLY_SUCCESS;
        }
        return Result.APPLY_FAIL;
    }

    /**
     * 离职申请
     * @return
     */
    @RequestMapping("addQuitApply")
    @ResponseBody
    public Result addQuitApply(Apply apply, HttpServletRequest request){
        if (apply == null) {
            return Result.APPLY_FAIL;
        }
        String empId = redisService.get(CookieUtil.getCookieValue(request, LoginController.TOKEN));
//        设置当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        apply.setEmployeeId(Long.valueOf(empId));
        apply.setDate(df.format(new Date()));
        int cols = applyService.insertApply(apply);
        if (cols > 0) {
            return Result.APPLY_SUCCESS;
        }
        return Result.APPLY_FAIL;
    }

    /**
     * 跳转到申请管理列表
     *
     * @return
     */
    @RequestMapping("applyList")
    public String applyList() {
        return "page/common/applyList";
    }

    /**
     * 管理员和普通员工都通过这个接口获取申请信息
     *
     * @param page
     * @param limit
     * @param applyState
     * @return
     */
    @RequestMapping("applyInfo")
    @ResponseBody
    public PageResult applyInfo(@RequestParam(required = false, defaultValue = "1") int page,
                                @RequestParam(required = false, defaultValue = "10") int limit,
                                @RequestParam(required = false) String applyState,
                                HttpServletRequest request) {
        String token = CookieUtil.getCookieValue(request, LoginController.TOKEN);
        String empId = redisService.get(token);
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo = PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        Apply query = new Apply();
        if (!StringUtils.isEmpty(applyState)) {
            query.setState(Integer.valueOf(applyState));
        }
        query.setEmployeeId(Long.valueOf(empId));
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
