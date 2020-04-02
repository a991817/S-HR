package com.dgut.shr.controller;

import com.dgut.shr.config.Result;
import com.dgut.shr.dto.PositionDto;
import com.dgut.shr.dto.PositionDto;
import com.dgut.shr.page.PageResult;
import com.dgut.shr.service.PositionService;
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
 * @date 2020/3/30 15:03
 */
@Controller
@RequestMapping("position")
public class PositionController {
    @Autowired
    PositionService positionService;
    /**
     * 跳转到部门详情
     * @return
     */
    @RequestMapping("positionList")
    public String employeeList(){
        return "page/system/positionList";
    }

    /**
     * 获取职位信息的json数据
     * @param page
     * @param limit
     * @param positionName
     * @return
     */
    @RequestMapping("positionInfo")
    @ResponseBody
    public PageResult positionInfo(@RequestParam(required = false,defaultValue = "1") int page,
                                   @RequestParam(required = false,defaultValue = "10") int limit,
                                   @RequestParam(required = false) String positionName){
//  创建Page对象，将page，limit参数传入，必须位于从数据库查询数据的语句之前，否则不生效
        Page pageInfo= PageHelper.startPage(page, limit);
// 从数据库查询，这里返回的的allUser就已经分页成功了
        PositionDto positionDto = new PositionDto();
        positionDto.setPositionName(positionName);
        List<PositionDto> dtos = positionService.selectList(positionDto);
// 获取查询记录总数，必须位于从数据库查询数据的语句之后，否则不生效
        long total = pageInfo.getTotal();
        PageResult pageResult = new PageResult();
        pageResult.setCode(0);
        pageResult.setCount(total);
        pageResult.setMsg("msg");
        pageResult.setData(dtos);
        return pageResult;
    }

    /**
     * 添加职位
     * @param positionDto
     * @param submitType
     * @return
     */
    @RequestMapping("positionAdd")
    @ResponseBody
    public Result positionAdd(PositionDto positionDto , String submitType){
        //编辑
        if ("edit".equals(submitType)){
            int cols = positionService.updatePosition(positionDto);
            if (cols > 0){
                return Result.POSITION_OPERATION_SUCCESS;
            }
            return Result.POSITION_OPERATION_FAIL;
        }
        //通过部门名称判断是否重复
        if (StringUtils.isEmpty(positionDto.getPositionName())){
            return Result.POSITION_OPERATION_FAIL;
        }
        if (positionService.getPositionBy(positionDto) != null){
            return Result.POSITION_OPERATION_FAIL;
        }
        //如果不存在就新增
        positionService.addPosition(positionDto);
        return Result.POSITION_OPERATION_SUCCESS;
    }

    @RequestMapping("deletePositionById")
    @ResponseBody
    public Result deletePositionById(PositionDto dto){
        int cols = positionService.deletePosition(dto);
        if (cols > 0){
            return Result.POSITION_OPERATION_SUCCESS;
        }
        return Result.POSITION_OPERATION_FAIL;
    }

    @RequestMapping("deletePositionMany")
    @ResponseBody
    public Result deletePositionMany(@RequestParam(value="ids[]") String[] ids){
        int cols = positionService.deletePositionMany(ids);
        if (cols > 0){
            return Result.POSITION_OPERATION_SUCCESS;
        }
        return Result.POSITION_OPERATION_FAIL;
    }

}
