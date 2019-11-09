<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>部门管理</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<style type="text/css">
	body{ 
		padding-top: 70px; 
	}
</style>

<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript">
	$(function(){
		$("#addDeptBtn").click(function(){
			$("#addDeptModal").modal();
			$("#saveNewDept").click(function(){
				var titleReg = /(^[\u4e00-\u9fa5]{1,10}$)|(^[a-zA-Z0-9_-]{1,20}$)/
				var deptName = $("#newDeptName").val();
				if(!titleReg.test(deptName)){
					$("#newDeptName").parent().addClass("has-error");
					$("#newDeptName").next().next().text("名称10个汉字或20个字符以内");
					return false;
				}else {
					$("#newDeptName").parent().removeClass("has-error");
					$("#newDeptName").next().next().text("");
				}
				var url = "${APP_PATH }/dept/dept";
				var args = $("#newDeptForm").serialize();
				$.post(url, args, function(result){
					alert("添加成功！");
					$("#newDeptName").val("");
					window.location.href = "${APP_PATH }/toDeptList.do";
				})
				return false;
			})
			
		})
		var deptId = null;
		$(document).on("click", ".editDeptBtn", function(){
			$("#editDeptModal").modal();
			deptId = $(this).attr("value");
			/* 根据ID获取部门名称 */
			var url = "${APP_PATH }/dept/dept/" + deptId;
			var args = {"date" : new Date()};
			$.get(url, args, function(result){
				var deptName = result.extend.dept.deptname;
				console.log(deptName);
				$("#editDeptName").val(deptName);
			})
			return false;
		})
		$("#editNewDept").click(function(){
			$("#editNewDept").attr("disabled", "disabled");
			setTimeout(function(){
				$("#editNewDept").removeAttr("disabled");
			}, 1000);
			
			var titleReg = /(^[\u4e00-\u9fa5]{1,10}$)|(^[a-zA-Z0-9_-]{1,20}$)/
			var deptName = $("#editDeptName").val();
			if(!titleReg.test(deptName)){
				$("#editDeptName").parent().addClass("has-error");
				$("#editDeptName").next().next().text("名称10个汉字或20个字符以内");
				return false;
			}else {
				$("#editDeptName").parent().removeClass("has-error");
				$("#editDeptName").next().next().text("");
			}
			
			var url = "${APP_PATH }/dept/dept/" + deptId;
			var args = $("#editDeptForm").serialize() + "&_method=put";
			$.post(url, args, function(result){
				alert("修改成功！");
				window.location.href = "${APP_PATH }/toDeptList.do";
			})
		})
		
	})
</script>

</head>
<body>
	<!-- 新增部门模态框 -->
	<div class="modal fade" id="addDeptModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加新部门</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="newDeptForm">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">部门名称</label>
							<div class="col-sm-10 has-feedback">
								<input name="deptname" type="input" class="form-control" id="newDeptName" 
								placeholder="不得超过10个字符">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
					</form>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="saveNewDept">添加</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 编辑模态框 -->
	<div class="modal fade" id="editDeptModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">编辑部门</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="editDeptForm">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">部门名称</label>
							<div class="col-sm-10 has-feedback">
								<input name="deptname" type="input" class="form-control" id="editDeptName" 
								placeholder="不得超过10个字符">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
					</form>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="editNewDept">提交</button>
				</div>
			</div>
		</div>
	</div>
	
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
						<li ><a href="${APP_PATH}/toNotice.do">首页 <span class="sr-only">(current)</span></a></li>
						<li ><a href="${APP_PATH}/tolist.do">员工管理</a></li>
						<li class="active">
							<a href="${APP_PATH }/toDeptList.do">部门管理</a>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
								员工论坛
								<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="${APP_PATH }/toForum.do">员工广场</a></li>
								<li><a href="${APP_PATH }/toReply.do">回复我的</a></li>
							</ul>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#">你好！&nbsp;</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
								&nbsp;${sessionScope.username }&nbsp;&nbsp;
								<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">个人信息</a></li>
								<li><a href="#">修改密码</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="${APP_PATH }/logout.do">注销登录</a></li>
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
		<div class="row">
			<div class="page-header">
				<h1>叮叮员工管理系统<small>&nbsp;&nbsp;部门管理</small></h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<ul class="nav navbar-nav navbar-right" >
				<div style="border: 0px, 0px;">
					<form class="navbar-form navbar-left">
						<div class="form-group">
						<!-- 
							<button type="button" class="btn btn-default" id="addDeptBtn">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								新增部门
							</button>
							 -->
						</div>
					</form>
				</div>
			</ul>	
		</div>
		<!-- 数据 -->
		<div class="row">
			<table class="table table-striped table-hover">
				<tr>
					<th>部门ID</th>
					<th>部门名称</th>
					<th>部门操作</th>
				</tr>
				<c:forEach items="${pageInfo.list }" var="dept">
					<tr>
						<td>${dept.deptid }</td>
						<td>${dept.deptname }</td>
						<td>
						<%-- 
							<button class="btn btn-success btn-sm  editDeptBtn"  value="${dept.deptid }">
								<span class="glyphicon glyphicon-pencil" 
								aria-hidden="true">
								</span>
								编辑
							</button>
							 --%>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		
		<div class="row">
				<ul class="nav navbar-nav">
					<br />
					<div>
						<h5>当前第${pageInfo.pageNum }页，共${pageInfo.pages }页，共查询到${pageInfo.total }条记录</h5>
					</div>
				</ul>
				<ul class="nav navbar-nav navbar-right" >
					<div id="p2" class="" style="border: 0px, 0px;">
						<nav aria-label="Page navigation">
							<ul class="pagination">
								<li><a href="${APP_PATH }/dept/getDepts?pn=1">首页</a></li>
								<c:if test="${pageInfo.hasPreviousPage }">
									<li>
										<a href="${APP_PATH }/dept/getDepts?pn=${pageInfo.pageNum - 1 }" aria-label="Previous"> 
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
								</c:if>
								
								<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
									<c:if test="${page_num == pageInfo.pageNum }">
										<li class="active"><a href="#">${page_num }</a></li>
									</c:if>
									<c:if test="${page_num != pageInfo.pageNum }">
										<li><a href="${APP_PATH }/dept/getDepts?pn=${page_num }">${page_num }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${pageInfo.hasNextPage }">
									<li>
										<a href="${APP_PATH }/dept/getDepts?pn=${pageInfo.pageNum + 1 }" aria-label="Next"> 
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</c:if>
								
								<li><a href="${APP_PATH }/dept/getDepts?pn=${pageInfo.pages }">尾页</a></li>
							</ul>
						</nav>
					</div>
				</ul>		
			</div>
			<nav class="navbar navbar-default navbar-fixed-bottom">
				<div class="container-fluid">
					<div class="navbar-header">
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="text-align: center; width: 1920px;">
							Copyright © 2019 - . All Rights Reserved.徐岩 版权所有
						</div>
					</div>
				</div>
			</nav>
		</div>
		
	</div>
	
</body>
</html>