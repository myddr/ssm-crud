package com.atguigu.spring.service;

import com.atguigu.spring.bean.Employee;
import com.atguigu.spring.bean.EmployeeExample;
import com.atguigu.spring.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll(){

        return employeeMapper.selectByExampleWithDept(null);
    }

    public void empSave(Employee employee) {
        employeeMapper.insertSelective(employee);
    }


    public Boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }


    public Employee getEmpData(Integer id) {
        return  employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    public void updateData(Employee employee) {
        employeeMapper.updateByPrimaryKey(employee);
    }

    public void deleteData(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
