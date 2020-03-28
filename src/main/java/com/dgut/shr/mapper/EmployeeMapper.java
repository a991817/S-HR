package com.dgut.shr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dgut.shr.dto.EmployeeDto;
import com.dgut.shr.javaBean.Employee;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface EmployeeMapper extends BaseMapper<Employee> {

    /**
     * 通过邮箱查看是否登录过
     * @param userDto
     * @return
     */
    Employee findUserByNameAndPwd(EmployeeDto userDto);

    /**
     * 查询所有员工数量
     * @return
     */
    int countAllEmployee();

    /**
     * 查询所有员工信息
     * @param dto
     * @return
     */
    List<EmployeeDto> selectList(EmployeeDto dto);

    /**
     * 根据身份证查询一个员工
     * @param employeeDto
     * @return
     */
    EmployeeDto getEmployeeBy(EmployeeDto employeeDto);

    /**
     * 新增一个员工
     * @param employeeDto
     * @return
     */
    int addEmployee(EmployeeDto employeeDto);

    /**
     * 更新一个员工
     * @param employeeDto
     * @return
     */
    int updateEmployee(EmployeeDto employeeDto);

    /**
     * 删除一个员工
     * @param employeeDto
     * @return
     */
    int deleteEmployee(EmployeeDto employeeDto);

    /**
     * 批量删除员工
     * @param ids
     * @return
     */
    int deleteEmployeeMany(String[] ids);

}