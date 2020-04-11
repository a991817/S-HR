package com.dgut.shr.service.impl;

import com.dgut.shr.javaBean.Apply;
import com.dgut.shr.mapper.ApplyMapper;
import com.dgut.shr.service.ApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shijie_liu
 * @date 2020/4/11 17:29
 */
@Service("applyService")
public class ApplyServiceImpl implements ApplyService {

    @Autowired
    ApplyMapper applyMapper;

    @Override
    public int insertApply(Apply apply) {
        return applyMapper.insertApply(apply);
    }

    @Override
    public int updateApply(Apply apply) {
        return applyMapper.updateApply(apply);
    }

    @Override
    public List<Apply> selectList(Apply apply) {
        return applyMapper.selectList(apply);
    }
}
