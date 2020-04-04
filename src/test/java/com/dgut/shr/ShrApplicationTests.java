package com.dgut.shr;

import com.dgut.shr.dto.DepartmentDto;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Address;
import com.dgut.shr.javaBean.Department;
import com.dgut.shr.mapper.AddressMapper;
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
    @Autowired
    AddressMapper addressMapper;
    @Test
   public void contextLoads() {
    }

    @Test
    public void testRedis(){
        redisTemplate.opsForValue().append("key","你好");
    }

    @Test
    public void testInsertAddress(){
        Address address = new Address();
        address.setProvince("广东");
        address.setCity("韶关");
        address.setArea("曲江");
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setId(Long.valueOf(3));
        employeeDto.setAddress(address);
        int i = addressMapper.insertAddress(employeeDto);
    }

    @Test
    public void testupdateAddress(){
        Address address = new Address();
        address.setProvince("广东");
        address.setCity("韶关");
        address.setArea("北江");
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setId(Long.valueOf(3));
        employeeDto.setAddress(address);
        int i = addressMapper.updateAddress(employeeDto);
    }

    @Test
    public void testGetAddressByEmpId(){
        EmployeeDto employeeDto = new EmployeeDto();
        employeeDto.setId(Long.valueOf(3));
        addressMapper.deleteAddress(employeeDto);
        System.out.println();
    }
}
