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
		javascript:window.history.forward(1);
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
		
		/* 修改密码 */
		$("#editPassword").click(function(){
			$("#editPasswordModal").modal();
			/* 根据session获取相应的用户信息 */
			
			var dbAnswer = null;
			var answer = $("#answer").val();
			var url = "${APP_PATH }/user/user/" + ${sessionScope.id };
			var args = {"date" : new Date()};
			$.get(url, args, function(result){
				var question = result.extend.user.question;
				dbAnswer = result.extend.user.answer;
				$("#question").text(question);
			})
			
			$("#saveNewPassword").click(function(){
				
				/* 检测密码 */
				var userReg = /^[a-zA-Z0-9_-]{4,16}$/;
				var password = $("#newPassword").val();
				var passwordPre = $("#newConfirmPassword").val();
				if(!userReg.test(password)){
					$("#newPassword").parent().removeClass("has-success");
					$("#newPassword").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#newPassword").parent().addClass("has-error");
					$("#newPassword").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#newPassword").next().next().text("密码由4到16位字母或数字组成");
					return false;
				}else {
					$("#newPassword").parent().removeClass("has-error");
					$("#newPassword").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#newPassword").parent().addClass("has-success");
					$("#newPassword").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#newPassword").next().next().text("");
				}
				if(password != passwordPre){
					$("#newConfirmPassword").parent().removeClass("has-success");
					$("#newConfirmPassword").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#newConfirmPassword").parent().addClass("has-error");
					$("#newConfirmPassword").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#newConfirmPassword").next().next().text("两次输入的密码不一致");
					return false;
				}else {
					$("#newConfirmPassword").parent().removeClass("has-error");
					$("#newConfirmPassword").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#newConfirmPassword").parent().addClass("has-success");
					$("#newConfirmPassword").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#newConfirmPassword").next().next().text("");
				}
				
				/* 检测密保问题答案 */
				if($("#answer").val() != dbAnswer){
					$("#answer").parent().removeClass("has-success");
					$("#answer").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#answer").parent().addClass("has-error");
					$("#answer").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#answer").next().next().text("密保问题答案错误");
					return false;
				}else {
					$("#answer").parent().removeClass("has-error");
					$("#answer").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#answer").parent().addClass("has-success");
					$("#answer").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#answer").next().next().text("");
				}
				
				var url = "${APP_PATH }/user/updateUserType/" + ${sessionScope.id};
				var args = {
					"password" : password,
					"_method" : "PUT"
				};
				$.post(url, args, function(result){
					alert("修改成功！");
					$("#editPasswordModal").modal("hide");
					window.location.reload();
				})
				
			})
		})
		$("#personInfo").click(function(){
			$("#empEditModal").modal({
				/* 点击背景不关闭 */
				backdrop: "static"
			});
			
			/* 每次打开模态框都即时更新要修改员工的ID */
			editID = $(this).attr("value");
			
			/* ajax获取部门信息 */
			var url = "${APP_PATH}/dept/depts";
			var args = {
				"date": new Date()
			};
			$.get(url, args, function(result) {
				var depts = result.extend.depts;
				$("#editEmpBtnSelect").empty();
				$.each(depts, function(index, item) {
					$("#editEmpBtnSelect").append($("<option></option>").text(item.deptname).val(item.deptid));
				})
			})
			
			
			/* 获取员工信息并回显 */
			var url = "${APP_PATH}/emp/emp/" + editID;
			var args = {
				"date": new Date()
			};
			$.get(url, args, function(result) {
				var emp = result.extend.employee;
				$("#editEmpBtnName").text(emp.lastName);
				if (emp.gender == "Male") {
					$("#editEmpBtnFemale").attr("checked", false);
					$("#editEmpBtnMale").attr("checked", true);
				} else {
					$("#editEmpBtnMale").attr("checked", false);
					$("#editEmpBtnFemale").attr("checked", true);
				}
				$("#editEmpBtnEmail").val(emp.email);
				$("#editEmpBtnSelect option").each(function(index, item) {
					if ($(item).val() == emp.deptid) {
						$(item).attr("selected", true);
					} else {
						$(item).attr("selected", false);
					}
				})
			})
			
			$("#editEmpBtn").click(function() {
				$("#editEmpBtn").attr("disabled", "disabled");
				setTimeout(function() {
					$("#editEmpBtn").removeAttr("disabled");
				},1000)
				/* 校验邮箱格式 */
				var email = $("#editEmpBtnEmail").val();
				var emailReg = /^([A-Za-z0-9_\-\.\u4e00-\u9fa5])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,8})$/;
				emailReg.test(email);
				if (!emailReg.test(email)) {
					$("#editEmpBtnEmail").parent().removeClass("has-success");
					$("#editEmpBtnEmail").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#editEmpBtnEmail").parent().addClass("has-error");
					$("#editEmpBtnEmail").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#editEmpBtnEmailHelpBlock").text("邮箱格式不正确");
					return false;
				} else {
					$("#editEmpBtnEmail").parent().removeClass("has-error");
					$("#editEmpBtnEmail").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#editEmpBtnEmail").parent().addClass("has-success");
					$("#editEmpBtnEmail").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#editEmpBtnEmailHelpBlock").text("邮箱格式正确");
				}
				$("#editEmpBtn").attr("disabled", "disabled");
				/* 如果没有问题则提交 */
				var url = "${APP_PATH}/emp/emp/" + editID;
				var args = $("#empEditForm").serialize() + "&_method=PUT";
				$.post(url, args, function(result) {
					/* 后端校验通过 */
					if (result.code == 200) {
						$("#empEditModal").modal("hide");
						$("#editEmpBtn").removeAttr("disabled", "disabled");
						/* 移除所有校验效果 */
						$("#editEmpBtnEmail").val("");
						$("#editEmpBtnEmail").parent().removeClass("has-success");
						$("#editEmpBtnEmail").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
						$("#editEmpBtnEmailHelpBlock").text("");
						
					} else {
						/* 后端校验未通过 */
						if (result.extend.errors.email != undefined) {
							alert(result.extend.errors.email);
						}else if(result.extend.errors.lastName != undefined){
							alert(result.extend.errors.lastName);
						}
					}
			
				})
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
	
	<!-- 修改密码模态框 -->
	<div class="modal fade" id="editPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改密码</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="newNoticeForm">
						
						<div class="form-group">
							<label class="col-sm-2 control-label">密保问题</label>
							<div class="col-sm-10">
								<p id="question" class="form-control-static"></p>
								<input type="hidden" name="lastName" id="editInputName" value="">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">答案</label>
							<div class="col-sm-10 has-feedback">
								<input name="title" type="input" class="form-control" id="answer" placeholder="密保问题对应的答案">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="title" type="input" class="form-control" id="newPassword" placeholder="新密码">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">确认新密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="title" type="input" class="form-control" id="newConfirmPassword" placeholder="重复输入新密码">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
	
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="saveNewPassword">修改</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改信息</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="empEditForm">
						<div class="form-group">
							<label class="col-sm-2 control-label">Name</label>
							<div class="col-sm-10">
								<p id="editEmpBtnName" class="form-control-static"></p>
							</div>
						</div>
	
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="gender" id="editEmpBtnMale" value="Male" checked="checked">
									Male
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" id="editEmpBtnFemale" value="Female">
									Female
								</label>
							</div>
						</div>
	
						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10 has-feedback">
								<input name="email" type="input" class="form-control" id="editEmpBtnEmail" placeholder="邮箱地址">
								<span></span>
								<span id="editEmpBtnEmailHelpBlock" class="help-block"></span>
							</div>
						</div>
	
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Department</label>
							<div class="col-sm-4">
								<select id="editEmpBtnSelect" class="form-control" name="deptid">
	
								</select>
							</div>
						</div>
					</form>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="editEmpBtn">Edit</button>
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
								<li><a href="#" id="personInfo" value="${sessionScope.id }">个人信息</a></li>
								<li><a href="#" id="editPassword">修改密码</a></li>
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
							<button type="button" class="btn btn-default" id="addDeptBtn">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								新增部门
							</button>
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
							<button class="btn btn-success btn-sm  editDeptBtn"  value="${dept.deptid }">
								<span class="glyphicon glyphicon-pencil" 
								aria-hidden="true">
								</span>
								编辑
							</button>
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