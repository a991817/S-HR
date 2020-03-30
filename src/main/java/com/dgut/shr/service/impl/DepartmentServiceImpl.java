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
        return departmentMapper.selectList(dto);
    }

    @Override
    public List<DepartmentDto> selectDepInfo(DepartmentDto dto) {
        return departmentMapper.selectDepInfo(dto);
    }

    @Override
    public int addDepartment(DepartmentDto dto) {
        return departmentMapper.addDepartment(dto);
    }

    @Override
    public int updateDepartment(DepartmentDto dto) {
        return departmentMapper.updateDepartment(dto);
    }

    @Override
    public int deleteDepartment(DepartmentDto dto) {
        return departmentMapper.deleteDepartment(dto);
    }

    @Override
    public int deleteDepartmentMany(String[] ids) {
        return departmentMapper.deleteDepartmentMany(ids);
    }

    @Override
    public DepartmentDto getDepartmentBy(DepartmentDto dto) {
        return departmentMapper.getDepartmentBy(dto);
    }


}
