<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script src="static/bootstrap-3.3.7-dist/js/jquery-2.0.0.js"></script>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js" rel="stylesheet">

    <link rel="shortcut icon" href="#"/>


</head>
<body>

<%--员工修改的模态框--%>
<div class="modal fade" id="empupdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="aaa@aaa.aaa">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门提交部门id--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="modale_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="aaa@aaa.aaa">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
<%--                            部门提交部门id--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="modal_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>




<%--    搭建显示页面--%>
<div class="container">
    <%--        标题--%>
    <div class="row">
        <div class="clo-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--        新加删除按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_btn">删除</button>
        </div>
    </div>
    <%--        显示表格内容--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_All"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--        显示分页信息--%>
    <div class="row">
        <%--            分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--            分页条信息--%>
        <div class="col-md-6">

        </div>
    </div>
</div>

<script type="text/javascript" >

    var totalPage,nowPage;


    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function (result) {
                //解析员工数据
                build_emps_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析并显示分页数据
                build_page_nav(result);
            }
        });
    }

    //解析数据
    function build_emps_table(result) {
        var emps = result.extend.PageInfo.list;
        $("#emps_tables tbody").empty();
        $.each(emps,function(index,item){
            var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var GenderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var departmentName = $("<td></td>").append(item.department.deptName);


            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil").append("编辑");
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash").append("删除");
            delBtn.attr("del-id",item.empId);
            var editnew = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkboxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(GenderTd)
                .append(emailTd)
                .append(departmentName)
                .append(editnew)
                .appendTo("#emps_tables tbody")
        });
    }

    //显示数据
    function build_page_info(result) {

        $("#page_info_area").empty();
        $("#page_info_area").append("当前" +result.extend.PageInfo.pageNum+"页，总"
            +result.extend.PageInfo.pages+"页，" +
            "共"+result.extend.PageInfo.total+"条记录")
        totalPage = result.extend.PageInfo.pages;
        nowPage = result.extend.PageInfo.pageNum;
    }

    //分页条
    function build_page_nav(result) {
        $("#page_info_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var first_pageli = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi =  $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.PageInfo.hasPreviousPage == false){
            first_pageli.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加翻页事件
            first_pageli.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.PageInfo.pageNum - 1);
            });
        }

        var nextPageLi =  $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi =  $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if(result.extend.PageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.PageInfo.pageNum +1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.PageInfo.pages);
            });
        }
        ul.append(first_pageli).append(prePageLi);
        $.each(result.extend.PageInfo.navigatepageNums,function (index,item) {
            var numli = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.PageInfo.pageNum == item){
                numli.addClass("active");
            }
            numli.click(function () {
                to_page(item);
            });

            ul.append(numli);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_info_area");

    }

    //清空模态框数据和样式显示
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //新增弹出模态框
    $("#emp_add_model_btn").click(function () {
        //清空数据
        reset_form("#empAddModel form");
        //从数据库查出下拉框数据
        getDepts("#empAddModel select");
        //弹出模态框
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });

    //发送ajax请求获取departmentName,显示下拉框数据
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/dept",
            type:"GET",
            success:function(result){
                $.each(result.extend.dept,function () {
                    var opentionNext = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    opentionNext.appendTo(ele);
                })
            }
        })
    }

    //保存按钮
    $("#modal_save_btn").click(function () {

        //先进行数据合法性校验
        if(!validata_register()){
            return false;
        }

        if($(this).attr("ajax-va") == "error"){
            return false;
        }
        //数据校验成功以后保存数据
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function (result) {
                if (result.code == 200){
                    $("#empAddModel").modal("hide");
                    to_page(totalPage);
                }else {
                    if (undefined != result.extend.errorFailed.email){
                        validata_msg("#email_add_input","error",result.extend.errorFaileds.email)
                    }
                    if (undefined != result.extend.errorFaileds.empName){
                        validata_msg("#empName_input","error",result.extend.errorFaileds.empName)
                    }

                }
            }
        })
    });

    //更新按钮
    $("#modale_update_btn").click(function () {
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            validata_msg("#email_update_input","error","邮箱格式不正确")
            return false;
        }else {
            validata_msg("#email_update_input","error","");
        }

        //发送ajax请求更新保存后的数据
        $.ajax({
            url:"${APP_PATH}/emps/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empupdateModel form").serialize(),
            success:function (result) {
                if (result.code == 200){
                    $("#empupdateModel").modal("hide");
                    to_page(nowPage);
                }
            }

        })
    });

    //对用户名和邮箱进行数据校验
    function validata_register() {

        var empName = $("#empName_input").val();
        var regName = /(^[a-zA-Z0-9]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            // alert("请输入正确的empName,必须时6-16为数字和英文组合！");
            validata_msg("#empName_input","error","用户名必须6-16为数字和英文组合！");
            return false;
        }else {
            validata_msg("#empName_input","success","");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            // alert("请输入合法的邮箱");
            $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("请输入合法的邮箱");
            return false;
        }

        return true;
    }

    //对用户名进行校验
    function validata_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if (status == "error"){
            $(ele).parent().addClass("has-error");
            $("#empName_input").next("span").text(msg);
        }else if(status == "success"){
            $(ele).parent().addClass("has-success");
            $("#empName_input").next("span").text(msg);
        }

    }
    //校验用户名是否符合re规则
    $("#empName_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checks",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if (result.code==200){
                    validata_msg("#empName_input","success","用户名可用");
                    $("#modal_save_btn").attr("ajax-va","success");
                }else {
                    validata_msg("#empName_input","error",result.extend.va_name);
                    $("#modal_save_btn").attr("ajax-va","error");

                }
            }
        })
    });



    //打开编辑模态框
    $(document).on("click",".edit_btn",function () {
        reset_form("#empupdateModel form");
        //从数据库查出下拉框数据
        getDepts("#empupdateModel select");
        getEmp($(this).attr("edit-id"));
        $("#modale_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empupdateModel").modal({
            backdrop:"static"
        });
    });

    //单一删除
    $(document).on("click",".delete_btn",function () {
       var empName = $(this).parents("tr").find("td:eq(2)").text();
       var empId = $(this).attr("del-id");
       if (confirm("确认删除[" + empName + "]吗?")){

           $.ajax({
               url:"${APP_PATH}/emps/"+empId,
               type:"DELETE",
               success:function (result) {
                   alert("删除成功");
                   to_page(nowPage);
               }
           })
       }

    });

    //点击编辑按钮发送ajax请求回显数据
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emps/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empupdateModel input[name=gender]").val([empData.gender]);
                $("#empupdateModel select").val([empData.dId])
            }
        })
    }

    $("#check_All").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });



    $(document).on("click",".check_item",function(){
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_All").prop("checked",flag);

    });


    $("#emp_delete_btn").click(function(){
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length -1);
        del_idstr = del_idstr.substring(0,del_idstr.length -1);
        if (confirm("确认删除["+empNames+"]吗?")){
            $.ajax({
                url:"${APP_PATH}/emps/"+del_idstr,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到当前页
                    to_page(nowPage);
                }
            })
        }
    })

</script>

</body>

</html>