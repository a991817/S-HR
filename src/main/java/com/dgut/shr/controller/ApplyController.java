package com.dgut.shr.controller;

import com.dgut.shr.config.Result;
import com.dgut.shr.javaBean.Apply;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.ApplyService;
import com.dgut.shr.service.sys.RedisService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        if (res == null) {
            return Result.FAIL;
        }
//        判断是审批什么的，签到，签退，请假
        if (apply.getType() == 1 || apply.getType() == 2) {
//        签到或者签退补卡
            applyService.signInOrOutApply(res);
        } else if (apply.getType() == 3) {
//        请假
            applyService.leaveApply(res);
        } else if (apply.getType() == 4) {
//        离职
            applyService.quitApply(res);
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
     * 管理员和普通员工都通过这个接口获取申请信息
     *
     * @param page
     * @param limit
     * @param empName
     * @param applyState
     * @return
     */
    @RequestMapping("applyInfo")
    @ResponseBody
    public PageResult applyInfo(@RequestParam(required = false, defaultValue = "1") int page,
                                @RequestParam(required = false, defaultValue = "10") int limit,
                                @RequestParam(required = false) String empName,
                                @RequestParam(required = false) String applyState) {
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo = PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        Apply query = new Apply();
        if (!StringUtils.isEmpty(empName)) {
            query.setName(empName);
        }
        if (!StringUtils.isEmpty(applyState)) {
            query.setState(Integer.valueOf(applyState));
        }
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
