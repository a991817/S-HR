package com.dgut.shr.service.impl;

import com.dgut.shr.dto.BonusDto;
import com.dgut.shr.mapper.BonusMapper;
import com.dgut.shr.service.BonusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author shijie_liu
 * @date 2020/4/22 18:46
 */
@Service("bonusService")
public class BonusServiceImpl implements BonusService {
    @Autowired
    BonusMapper bonusMapper;
    @Override
    public int insertBatch(BonusDto dto) {
        //        获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");//设置日期格式
        Date date = new Date();
//        判断是发年终奖还是发当月奖金
//        如果是年终奖的话月份设置为12月
        if ("1".equals(dto.getType())){
            date.setMonth(11);
        }
        dto.setPayYearMonth(df.format(date));
//        如果是当月奖金的话月份为当月
        return bonusMapper.insertBatch(dto);
    }
}
