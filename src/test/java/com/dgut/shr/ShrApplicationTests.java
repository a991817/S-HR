package com.dgut.shr;

import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Department;
import com.dgut.shr.mapper.DepartmentMapper;
import com.dgut.shr.mapper.EmployeeMapper;
import com.dgut.shr.service.DepartmentService;
import com.dgut.shr.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class ShrApplicationTests {
    @Autowired
    RedisTemplate redisTemplate;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    EmployeeService employeeService;
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Test
   public void contextLoads() {
    }

    @Test
    public void testRedis(){
        redisTemplate.opsForValue().append("key","你好");
    }

    @Test
    public void testService(){
        List<Department> departmentDtos = departmentMapper.selectList(null);
        for (Department departmentDto : departmentDtos) {
            System.out.println(departmentDto.getDepName());
        }
         employeeMapper.countAllEmployee();
    }

}
