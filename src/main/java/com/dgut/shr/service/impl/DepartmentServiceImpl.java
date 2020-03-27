package com.dgut.shr.service.impl;

import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.mapper.DepartmentMapper;
import com.dgut.shr.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public List<DepartmentDto> selectList(DepartmentDto dto) {
        return departmentMapper.selectListFuck1(dto);
    }
}
