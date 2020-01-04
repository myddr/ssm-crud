package com.atguigu.spring.test;

import com.atguigu.spring.bean.Department;
import com.atguigu.spring.bean.Employee;
import com.atguigu.spring.dao.DepartmentMapper;
import com.atguigu.spring.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml"})
public class CrudTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void test(){
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("spring.xml");
//        Object departmentMapper = ioc.getBean("departmentMapper");
//        departmentMapper.insertSelective(new Department(null,"运维部"));
//        departmentMapper.insertSelective(new Department(null,"人事部"));

//        employeeMapper.insertSelective(new Employee(null,"dmx","b","330104805@qq.com",1));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);

//        for (int i = 0; i < 1000; i++) {
//            String uid = UUID.randomUUID().toString().substring(0, 5);
//            mapper.insertSelective(new Employee(null,uid+"dmx","b",uid+"@qq.com",1));
//        }
//        System.out.println("批量完成");

        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);



    }
}
