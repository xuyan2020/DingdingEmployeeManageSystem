<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>叮叮员工管理系统</title>
	<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>
	<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.js"></script>
	<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
	<script type="text/javascript">
		$(function(){
			$("#login").hover(function(){
				$(this).removeAttr("style");
			},function(){
				$(this).attr("style", "background-color: rgba(0, 0, 0, 0);color: white");
			})
			$("#login").click(function() {
				$("#loginModal").modal({
					/* 点击背景不关闭 */
					backdrop: "static"
				});
				
			})
			$("#register").click(function() {
				$("#regModal").modal({
					/* 点击背景不关闭 */
					backdrop: "static"
				});
				
			})
		})
	</script>
	
</head>
<body>
	<!-- 登录模态框 -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">登录</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" id="editEmpForm">
						<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
								<div class="col-sm-10 has-feedback">
									<input name="username" type="input" class="form-control" id="usernameLogin" placeholder="用户名">
									<span></span>
									<span id="nameHelpBlock" class="help-block"></span>
								</div>
							</div>

						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="password" type="password" class="form-control"
									id="passwordLonin" placeholder="密码"> 
									<span></span> 
									<span id="editEmailHelpBlock" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">登录类型</label>
							<div class="col-sm-4">
								<select id="usertypeLogin" class="form-control" name="usertype">
									<option>管理员</option>
									<option>员工</option>
								</select>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="loginBtn">登录</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 注册模态框 -->
	<div class="modal fade" id="regModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">注册</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" id="editEmpForm">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">员工ID</label>
							<div class="col-sm-10 has-feedback">
								<input name="username" type="input" class="form-control" id="empIdReg" placeholder="ID">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10 has-feedback">
								<input name="username" type="input" class="form-control" id="empNameReg" placeholder="姓名">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10 has-feedback">
								<input name="username" type="input" class="form-control" id="usernameReg" placeholder="用户名">
								<span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="password" type="password" class="form-control"
									id="passwordReg" placeholder="密码"> 
									<span></span> 
									<span id="editEmailHelpBlock" class="help-block"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="password" type="password" class="form-control"
									id="passwordConfirmReg" placeholder="再次输入密码"> 
									<span></span> 
									<span id="editEmailHelpBlock" class="help-block"></span>
							</div>
						</div>

						
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="regBtn">注册</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 背景大图，登陆注册按钮 -->
	<div class="jumbotron" style="background-image: url('${APP_PATH }/pics/1111.jpg'); height:1000px">
		<div class="container">
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<br>
			</div>
			<div class="row">
				<h1 style="color: white;">叮叮员工管理系统</h1>
			</div>

			<p></p>
			
			<div class="row">
				<br>
			</div>
			
			<a id="register" class="btn btn-primary btn-lg" href="#" role="button">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注册&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a id="login" class="btn btn-default btn-lg" href="#" role="button"
				style="background-color: rgba(0, 0, 0, 0); color: white;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;登录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</a>
		</div>
	</div>


</body>
</html>