package com.atguigu.spring.service;

import com.atguigu.spring.bean.Department;
import com.atguigu.spring.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }
}
