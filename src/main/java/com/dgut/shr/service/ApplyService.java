package com.dgut.shr.service;

import com.dgut.shr.javaBean.Apply;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/11 17:29
 */
public interface ApplyService {
    /**
     * 插入一个申请记录
     * @param dto
     * @return
     */
    int insertApply(Apply dto);

    /**
     * 更新一个申请记录
     * @param dto
     * @return
     */
    int updateApply(Apply dto);

    /**
     * 查询所有申请记录
     * @param apply
     * @return
     */
    List<Apply> selectList(Apply apply);
}
