package com.atguigu.spring.controller;

import com.atguigu.spring.bean.Employee;
import com.atguigu.spring.bean.Msg;
import com.atguigu.spring.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    //查询所有员工数据
    @RequestMapping("/emps")
    @ResponseBody
    public Msg jackson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);

        List<Employee> emps = employeeService.getAll();

        PageInfo page = new PageInfo<Employee>(emps);

        return Msg.success().add("PageInfo",page);
    }

    //编辑修改员工数据
    @ResponseBody
    @RequestMapping(value = "/emps/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateData(employee);
        return Msg.success();
    }

    //
    @RequestMapping("/emps/{id}")
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmpData(id);
        return Msg.success().add("emp",employee);
    }


    //单个删除和批量删除二合一
    @ResponseBody
    @RequestMapping(value = "/emps/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        //批量删除
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            for (String str : str_ids){
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }
        //单个删除
        else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteData(id);
        }


        return Msg.success();
    }


    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    @ResponseBody
    public Msg save(@Valid Employee employee, BindingResult result){
        //校验失败,返回失败，在模态框显示校验失败的错误信息
        if (result.hasErrors()){
            Map<String,Object> maps = new HashMap<String,Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError: errors){
                System.out.println("错误的字段名" + fieldError.getField());
                System.out.println("错误信息:" + fieldError.getDefaultMessage());
                maps.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFaileds",maps);
        }else {
            employeeService.empSave(employee);
            return Msg.success();
        }

    }

    @ResponseBody
    @RequestMapping(value = "/checks",method = RequestMethod.POST)
    public Msg check(@RequestParam("empName") String empName){
        Boolean b = employeeService.checkUser(empName);
        String regName = "(^[a-zA-Z0-9]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regName)){
            return Msg.fail().add("va_name","用户名必须6-16为数字和英文组合");
        }
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_name","用户名不可用");
        }

    }



//    @RequestMapping("/emps")
    public String select(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);

        List<Employee> emps = employeeService.getAll();

        PageInfo page = new PageInfo<Employee>(emps);

        model.addAttribute("PageInfo",page);

        return "list";

    }
}
