package com.dgut.shr.service.impl;

import com.dgut.shr.dto.BonusDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.mapper.BonusMapper;
import com.dgut.shr.service.BonusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

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
//        如果是年终奖的话月份设置为12月,并且把之前设置的年终奖删除，因为年终奖只发一次
        if ("1".equals(dto.getType())){
            date.setMonth(11);
            dto.setPayYearMonth(df.format(date));
            bonusMapper.deleteBatch(dto);
        }else {
            dto.setPayYearMonth(df.format(date));
        }
//        如果是当月奖金的话月份为当月
        return bonusMapper.insertBatch(dto);
    }

    @Override
    public int insertBatch(String[] ids, String bonus) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");//设置日期格式
        Date date = new Date();
        BonusDto dto = new BonusDto();
        dto.setBonus(bonus);
        dto.setType("2");
        dto.setPayYearMonth(df.format(date));
        List<String> idsList = new ArrayList<>();
        for (String s : ids) {
            idsList.add(s);
        }
        dto.setIds(idsList);
        return bonusMapper.insertBatch(dto);
    }
}
