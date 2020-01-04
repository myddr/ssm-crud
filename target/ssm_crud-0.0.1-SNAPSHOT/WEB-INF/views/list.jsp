<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>


    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js" rel="stylesheet">
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.js" rel="stylesheet">
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/jquery/jquery.min.js" rel="stylesheet">

</head>
<body>
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
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--        显示表格内容--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${PageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑</button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除</button>
                        </th>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <%--        显示分页信息--%>
    <div class="row">
        <%--            分页文字信息--%>
        <div class="col-md-6">
            当前${PageInfo.pageNum}页，总${PageInfo.pages}页，共${PageInfo.total}条记录
        </div>
        <%--            分页条信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="http://localhost/ssm_crud_war/emps?pn=1">首页</a></li>
                    <c:if test="${PageInfo.hasPreviousPage}">
                        <li>
                            <a href="http://localhost/ssm_crud_war/emps?pn=${PageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!PageInfo.hasPreviousPage}">
                        <li>
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>


                    <c:forEach items="${PageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == PageInfo.pageNum}">
                            <li class="active"><a href="#" >${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != PageInfo.pageNum}">
                            <li><a href="http://localhost/ssm_crud_war/emps?pn=${page_Num}" >${page_Num}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${PageInfo.hasNextPage}">
                        <li>
                            <a href="http://localhost/ssm_crud_war/emps?pn=${PageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!PageInfo.hasNextPage}">
                        <li>
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li><a href="http://localhost/ssm_crud_war/emps?pn=${PageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>


</body>
</html>