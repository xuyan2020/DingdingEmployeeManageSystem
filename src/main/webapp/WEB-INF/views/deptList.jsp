<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
</head>
<body>
		<!-- 标题栏 -->
		<div class="row">
			<nav class="navbar navbar-default navbar-fixed-top">
				<div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						 aria-expanded="false">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">Brand</a>
					</div>
		
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li><a href="#">首页 <span class="sr-only">(current)</span></a></li>
							<li><a href="${APP_PATH}/toList">员工管理</a></li>
							<li class="active">
								<a href="#">部门管理</a>
							</li>
						</ul>
							<!-- 按钮下拉列表 -->
							<!--
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">部门管理
								</a>
								 <ul class="dropdown-menu">
										<li><a href="#">Action</a></li>
										<li><a href="#">Another action</a></li>
										<li><a href="#">Something else here</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">Separated link</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="#">One more separated link</a></li>
									  </ul> -->
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#">注册</a></li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">登陆
									<span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="#">Action</a></li>
									<li><a href="#">Another action</a></li>
									<li><a href="#">Something else here</a></li>
									<li role="separator" class="divider"></li>
									<li><a href="#">Separated link</a></li>
								</ul>
							</li>
						</ul>
					</div><!-- /.navbar-collapse -->
				</div><!-- /.container-fluid -->
			</nav>
		</div>
	<!-- 显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="page-header">
			<h1>叮叮员工管理系统<small>CRUD</small></h1>
		</div>
		<!-- 按钮 -->
			<div class="row">
				<ul class="nav navbar-nav">
					<div  class="">
						<button type="button" class="btn btn-default" id="addEmpModalBtn">添加</button>
						<button type="button" class="btn btn-default" id="delEmpModalBtn">删除</button>
					</div>
				</ul>
				<ul class="nav navbar-nav navbar-right" >
					<div  class="" style="border: 0px, 0px;">
						<form class="navbar-form navbar-left">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="可根据姓名进行模糊查找">
							</div>
							<button type="submit" class="btn btn-default">查找</button>
						</form>
					</div>
				</ul>	
				
			</div>
		<!-- 数据 -->
		<div class="row">
			<table class="table table-striped table-hover">
				<tr>
					<th>#</th>
					<th>Name</th>
					<th>Gender</th>
					<th>Email</th>
					<th>DeptID</th>
					<th>DeptName</th>
					<th>Operation</th>
				</tr>
				<c:forEach items="${pageInfo.list }" var="emp">
					<tr>
						<th>
							<input type="checkbox" id="checkBoxAll" />
						</th>
						<td>${emp.id }</td>
						<td>${emp.lastName }</td>
						<td>${emp.gender }</td>
						<td>${emp.email }</td>
						<td>${emp.deptid }</td>
						<td>${emp.department.deptname }</td>
						<td>
							<button class="btn btn-success btn-sm">
								<span class="glyphicon glyphicon-pencil editEmpBtn" aria-hidden="true" value="${emp.id }"
									>
								</span>
								编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-7">
				<h5>当前第${pageInfo.pageNum }页，共${pageInfo.pages }页，共查询到${pageInfo.total }条记录</h5>
			</div>
			<div class="col-md-5  col-md-offset-7">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						<c:if test="${pageInfo.hasPreviousPage }">
							<li>
								<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum - 1 }" aria-label="Previous"> 
									<spanaria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>
						
						<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
							<c:if test="${page_num == pageInfo.pageNum }">
								<li class="active"><a href="#">${page_num }</a></li>
							</c:if>
							<c:if test="${page_num != pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${page_num }">${page_num }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage }">
							<li>
								<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum + 1 }" aria-label="Next"> 
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:if>
						
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages }">尾页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	
</body>
</html>
