<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工广场</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<style type="text/css">
	body{ 
		padding-top: 70px; 
	}
	html {
	position: relative;
	min-height: 100%;
	}
	body {
		margin-bottom: 60px;
	}
	.footer {
		position: absolute;
		bottom: 0;  width: 100%;
		/* Set the fixed height of the footer here */
		height: 60px;
		background-color: #f5f5f5;
	}
	
</style>

<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript">
	$(function(){
		javascript:window.history.forward(1);
		/* 发布文章 */
		$("#addNoticeBtn").click(function(){
			$("#addNoticeModal").modal();
			
			/* 点击发布按钮后 */
			$("#saveNewNotice").click(function(){
				$("#saveNewNotice").attr("disabled", "disabled");
				setTimeout(function(){
					$("#saveNewNotice").removeAttr("disabled");
				}, 1500);
				var titleReg = /(^[\u4e00-\u9fa5]{1,20}$)|(^[a-zA-Z0-9_-]{1,40}$)/
				var contentReg = /^[\w\W]{1,100}$/
				var title = $("#newTitle").val();
				var content = $("#newContent").val();
				if(!titleReg.test(title)){
					$("#newTitle").parent().addClass("has-error");
					$("#newTitle").next().next().text("标题20个汉字或40个字符以内");
					return false;
				}else {
					$("#newTitle").parent().removeClass("has-error");
					$("#newTitle").next().next().text("");
				}
				if(!contentReg.test(content)){
					$("#newContent").parent().addClass("has-error");
					$("#newContent").next().next().text("正文100个汉字或200个字符以内");
					return false;
				}else {
					$("#newContent").parent().removeClass("has-error");
					$("#newContent").next().next().text("");
				}
				
				/* 合格之后提交新文章 */
				var url = "${APP_PATH }/article/article";
				var args = $("#newNoticeForm").serialize();
				$.post(url, args, function(result){
					window.location.href = "${APP_PATH }/toForum.do";
				})
				
			})
			
		})
		
		/* 修改文章 */
		$(document).on("click", ".editNoticeBtn", function(){
			$("#editNoticeModal").modal();
			
			
			/* 获取该文章内容并回显 */
			var articleId = $(this).attr("value");
			var url = "${APP_PATH }/article/article/" + articleId;
			var args = {"date" : new Date()};
			$.get(url, args, function(result){
				var article = result.extend.article;
				$("#editTitle").val(article.title);
				$("#editContent").val(article.content);
				
			})
			
			/* 点击保存按钮 */
			$("#saveEditNotice").click(function(){
				$("#saveEditNotice").attr("disabled", "disabled");
				setTimeout(function(){
					$("#saveEditNotice").removeAttr("disabled");
				}, 1500);
				var url = "${APP_PATH }/article/article/" + articleId;
				var args = $("#editNoticeForm").serialize() + "&_method=PUT";
				$.post(url, args, function(result){
					alert("保存成功！");
					window.location.href = "${APP_PATH }/toForum.do";
				})
			})
			return false;
		})
		
		/* 删除文章 */
		$(document).on("click", ".delNoticeBtn", function(){
			var flag = confirm("是否确定删除该篇文章？");
			if(flag){
				var articleId = $(this).attr("value");
				var url = "${APP_PATH }/article/article/" + articleId;
				var args = {"_method" : "DELETE"};
				$.post(url, args, function(result){
					alert("删除成功!");
					window.location.href = "${APP_PATH }/toForum.do";
				})
				
			}
			return false;
		})
		
		/* 删除评论 */
		$(document).on("click", ".delCommentBtn", function(){
			var flag = confirm("是否确定删除该条评论？");
			if(flag){
				var commentId = $(this).attr("value");
				var url = "${APP_PATH }/comment/comment/" + commentId;
				var args = {"_method" : "DELETE"};
				$.post(url, args, function(result){
					alert("删除成功!");
					window.location.href = "${APP_PATH }/toForum.do";
				})
				
			}
			return false;
		})
		
			/* 修改密码 */
		$("#editPassword").click(function(){
			$("#editPasswordModal").modal();
			/* 根据session获取相应的用户信息 */
			
			var dbAnswer = null;
			var answer = $("#answer").val();
			var url = "${APP_PATH }/user/user/" + ${sessionScope.id == null ? 0 : sessionScope.id };
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
				
				var url = "${APP_PATH }/user/updateUserType/" + ${sessionScope.id == null ? 0 : sessionScope.id };
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
		
		/* 评论功能 */
		$(document).on("click", ".commentNoticeBtn", function() {
			$("#commentModal").modal();
			var articleId = $(this).attr("value");
			
			$("#saveComment").click(function() {
				
				var contentReg = /^[\w\W]{1,100}$/
				var content = $("#commentContent").val();
				if(!contentReg.test(content)){
					$("#commentContent").parent().addClass("has-error");
					$("#commentContent").next().next().text("正文100个汉字或200个字符以内");
					return false;
				}else {
					$("#commentContent").parent().removeClass("has-error");
					$("#commentContent").next().next().text("");
				}
				alert(articleId);
				var url = "${APP_PATH }/comment/comment";
				var args = {
						"articleid" : articleId,
						"empid" : ${sessionScope.id},
						"content" : content,
						"publishtime" : new Date(),
						"_method" : "PUT"
				};
				$.post(url, args, function(result) {
					window.location.reload();
				})
				
				
				return false;
			})
			
			return false;
			
		})
		
	})
</script>
</head>
<body>
	
	<!-- 新贴模态框 -->
	<div class="modal fade" id="addNoticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">发布新帖子</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="newNoticeForm">
						<input type="hidden" name="empid"  value="${sessionScope.id }" />
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">标题</label>
							<div class="col-sm-10 has-feedback">
								<input name="title" type="input" class="form-control" id="newTitle" placeholder="不得超过20个字符">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
	
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">内容</label>
							<div class="col-sm-10">
								<textarea name="content" class="form-control" rows="5" id="newContent" placeholder="100个汉字或200个字符以内"></textarea>
								<span></span>
								<span class="help-block"></span>
							</div>
						</div>
	
					</form>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="saveNewNotice">发布</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改模态框 -->
	<div class="modal fade" id="editNoticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改通知</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="editNoticeForm">
						<input type="hidden" name="empid" value="${sessionScope.id}" />
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">标题</label>
							<div class="col-sm-10 has-feedback">
								<input name="title" type="input" class="form-control" id="editTitle" placeholder="不得超过20个字符">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
	
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">内容</label>
							<div class="col-sm-10">
								<textarea name="content" class="form-control" rows="5" id="editContent" placeholder="100个汉字或200个字符以内"></textarea>
								<span></span>
								<span class="help-block"></span>
							</div>
						</div>
	
					</form>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="saveEditNotice">保存</button>
				</div>
			</div>
		</div>
	</div>

		<!-- 评论模态框 -->
	<div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">发表评论</h4>
				</div>
				<div class="modal-body">
	
					<form class="form-horizontal" id="newNoticeForm">
						<input type="hidden" name="empid"  value="${sessionScope.id }" />
						
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">评论内容</label>
							<div class="col-sm-10">
								<textarea name="content" class="form-control" rows="5" 
									id="commentContent" placeholder="100个汉字或200个字符以内"></textarea>
								<span></span>
								<span class="help-block"></span>
							</div>
						</div>
	
					</form>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="saveComment">发布</button>
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
						<li >
							<a href="${APP_PATH }/toDeptList.do">部门管理</a>
						</li>
						<li class="dropdown active">
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
				<h1>叮叮员工管理系统<small>&nbsp;&nbsp;员工广场</small></h1>
			</div>
		</div>
		<div class="row">
			
			<ul class="nav navbar-nav navbar-right" >
				<div style="border: 0px, 0px;">
					<form class="navbar-form navbar-left">
						<div class="form-group">
							<button type="button" class="btn btn-default" id="addNoticeBtn">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								发布新帖子
							</button>
						</div>
					</form>
				</div>
			</ul>	
		</div>
		<div class="row">
			<c:forEach items="${pageInfo.list }" var="article">
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#" class="titleA" value="${article.id }"> 
									${article.title }
								</a>
							</h3>
							<h5>
								发布人: 
								<c:choose>
									<c:when test="${sessionScope.id == article.id }">我自己</c:when>
									<c:when test="${sessionScope.id != article.id }">${article.empid }</c:when>
								</c:choose>
								
							</h5>
							<h5>发布时间: <fmt:formatDate value="${article.publishtime }"  pattern="yyyy-MM-dd HH:mm:ss"/></h5>
							
							<h5>
								内容：<span class="toDept">${article.content }</span>
							</h5>
							<a href="#" value="${article.id }" class="commentNoticeBtn">评论</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="#" value="${article.id }" class="editNoticeBtn">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="#" value="${article.id }" class="delNoticeBtn">删除</a>
							
						</div>
						<div class="panel-collapse collapse in">
							<div class="panel-body">
								<c:forEach items="${requestScope.allComment }" var="comment">
									<blockquote>
										<c:if test="${comment.articleid == article.id }">
											<p><h5>${comment.content }</h5></p>
											<footer>Comment By 
											<cite title="Source Title">${comment.empid }</cite>
											<p><h5><fmt:formatDate value="${comment.publishtime }"  pattern="yyyy-MM-dd HH:mm:ss"/></h5></p>
											</footer>
											<a href="#" value="${comment.id }" class="delCommentBtn"><h6>删除</h6></a>
										</c:if>
									</blockquote>
									<br>
								</c:forEach>
								
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			
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
								<li><a href="${APP_PATH }/article/articles?pn=1">首页</a></li>
								<c:if test="${pageInfo.hasPreviousPage }">
									<li>
										<a href="${APP_PATH }/article/articles?pn=${pageInfo.pageNum - 1 }" aria-label="Previous"> 
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
								</c:if>
								
								<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
									<c:if test="${page_num == pageInfo.pageNum }">
										<li class="active"><a href="#">${page_num }</a></li>
									</c:if>
									<c:if test="${page_num != pageInfo.pageNum }">
										<li><a href="${APP_PATH }/article/articles?pn=${page_num }">${page_num }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${pageInfo.hasNextPage }">
									<li>
										<a href="${APP_PATH }/article/articles?pn=${pageInfo.pageNum + 1 }" aria-label="Next"> 
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</c:if>
								
								<li><a href="${APP_PATH }/article/articles?pn=${pageInfo.pages }">尾页</a></li>
							</ul>
						</nav>
					</div>
				</ul>		
			</div>
			
		</div>
		
	</div>

	
</body>
</html>