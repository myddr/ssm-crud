package com.atguigu.spring.controller;

import com.atguigu.spring.bean.Department;
import com.atguigu.spring.bean.Msg;
import com.atguigu.spring.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/dept")
    @ResponseBody
    public Msg getDepts(){
        List<Department> dept = departmentService.getAll();
        return Msg.success().add("dept",dept);
    }

}
