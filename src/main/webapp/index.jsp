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
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
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
			/* 点击登录模态框内登录按钮 */
			$("#loginBtn").click(function() {
				/* 点击后设置禁止点击，1.5秒后恢复 */
				$("#loginBtn").attr("disabled", "disabled");
				setTimeout(function() {
					$("#loginBtn").removeAttr("disabled");
				},1500)
				
				var username = $("#usernameLogin").val();
				var password = $("#passwordLonin").val();
				var usertype = null;
				$("#usertypeLogin option").each(function(index, item) {
					if($(item).prop("selected") == true){
						usertype = $(item).val();
					}
				})
				/* 发送AJAX请求 */
				var url = "${APP_PATH }/user/getUserByUsername";
				var args = {"name" : username};
				$.get(url, args, function(result) {
					var id = result.extend.user.empid;
					var dbPassword = result.extend.user.password;
					var dbUserType = result.extend.user.usertype;
					if(password != dbPassword){
						$("#alert4").hide();
						$("#alert3").show();
						
					}else {
						$("#alert3").hide();
						console.log(usertype);
						console.log(dbUserType);
						if(usertype != dbUserType){
							$("#alert4").show();
						}else {
							$("#alert4").hide();
							$("#usernameLogin").val("");
							$("#passwordLonin").val("");
							
							/* 转发到其他页面 */
							window.location.href = "${APP_PATH }/tolist.do?username=" + username + "&empid=" + id;
						}
					}
					return false;
					
				})
			})
			
			
			/* 点击主页注册按钮 */
			$("#register").click(function() {
				$("#regModal").modal({
					/* 点击背景不关闭 */
					backdrop: "static"
				});
			})
			
			/* 点击注册模态框注册按钮 */
			$("#regBtn").click(function() {
				$("#regBtn").attr("disabled", "disabled");
				setTimeout(function() {
					$("#regBtn").removeAttr("disabled");
				},1500)
				$("#alert2").hide();
				var empId = $("#empIdReg").val();
				var empName = $("#empNameReg").val();
				var regId = /^[0-9]+$/
				var regName = /^[a-zA-Z0-9_]{3,15}$/
				/* 检测姓名和ID */
				if(!regId.test(empId)){
					$("#empIdReg").parent().removeClass("has-success");
					$("#empIdReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#empIdReg").parent().addClass("has-error");
					$("#empIdReg").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#empIdReg").next().next().text("请正确输入员工ID");
					return false;
				}else {
					$("#empIdReg").parent().removeClass("has-error");
					$("#empIdReg").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#empIdReg").next().next().text("");
				}
				if(!regName.test(empName)){
					$("#empNameReg").parent().removeClass("has-success");
					$("#empNameReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#empNameReg").parent().addClass("has-error");
					$("#empNameReg").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#empNameReg").next().next().text("请正确输入员工姓名");
					return false;
				}else {
					$("#empNameReg").parent().removeClass("has-error");
					$("#empNameReg").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#empNameReg").next().next().text("");
				}
				
				/* 检测用户名 */
				var username = $("#usernameReg").val();
				var userReg = /^[a-zA-Z0-9_-]{4,16}$/;
				if(!userReg.test(username)){
					$("#usernameReg").parent().removeClass("has-success");
					$("#usernameReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#usernameReg").parent().addClass("has-error");
					$("#usernameReg").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#usernameReg").next().next().text("用户名由4到16位字母或数字组成");
					return false;
				}else {
					$("#usernameReg").parent().removeClass("has-error");
					$("#usernameReg").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#usernameReg").parent().addClass("has-success");
					$("#usernameReg").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#usernameReg").next().next().text("");
				}
				
				/* 检测密码 */
				var password = $("#passwordReg").val();
				var passwordPre = $("#passwordConfirmReg").val();
				if(!userReg.test(password)){
					$("#passwordReg").parent().removeClass("has-success");
					$("#passwordReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#passwordReg").parent().addClass("has-error");
					$("#passwordReg").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#passwordReg").next().next().text("密码由4到16位字母或数字组成");
					return false;
				}else {
					$("#passwordReg").parent().removeClass("has-error");
					$("#passwordReg").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#passwordReg").parent().addClass("has-success");
					$("#passwordReg").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#passwordReg").next().next().text("");
				}
				if(password != passwordPre){
					$("#passwordConfirmReg").parent().removeClass("has-success");
					$("#passwordConfirmReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#passwordConfirmReg").parent().addClass("has-error");
					$("#passwordConfirmReg").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#passwordConfirmReg").next().next().text("两次输入的密码不一致");
					return false;
				}else {
					$("#passwordConfirmReg").parent().removeClass("has-error");
					$("#passwordConfirmReg").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#passwordConfirmReg").parent().addClass("has-success");
					$("#passwordConfirmReg").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#passwordConfirmReg").next().next().text("");
				}
				var answer = $("#answer").val();
				var answerReg = /(^[\u4e00-\u9fa5]{2,8}$)|(^[\dA-Za-z_]{2,16}$)/;
				if(!answerReg.test(answer)){
					$("#answer").parent().removeClass("has-success");
					$("#answer").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
					$("#answer").parent().addClass("has-error");
					$("#answer").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
					$("#answer").next().next().text("字数控制在2到8个汉字之间");
					return false;
				}else {
					$("#answer").parent().removeClass("has-error");
					$("#answer").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
					$("#answer").parent().addClass("has-success");
					$("#answer").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
					$("#answer").next().next().text("");
				}
				
				/* 根据ID查找员工 */
				var url = "${APP_PATH }/emp/emp/" + empId;
				var args = {"date" : new Date()};
				$.get(url, args, function(result) {
					var empDbName = result.extend.employee.lastName;
					if(empDbName != empName){
						$("#alert1").show();
					}else {
						/* 若匹配到了员工 */
						$("#alert1").hide();
						/* 查找该员工是否注册过账号 */
						var url = "${APP_PATH }/user/userById";
						var args = {"id" : empId};
						$.get(url, args, function(result) {
							/* 如果查询到数据，即该员工注册过账号 */
							if(result.extend.count > 0){
								$("#alert2").show();
							}else{
								$("#regBtn").attr("disabled", "disabled");
								$("#alert2").hide();
								var url = "${APP_PATH }/user/addUser";
								args = $("#regForm").serialize();
								$.post(url, args, function(result) {
									$("#regModal").modal("hide");
									$("#empIdReg").val("");
									$("#empNameReg").val("");
									$("#usernameReg").parent().removeClass("has-success");
									$("#usernameReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
									$("#usernameReg").val("");
									$("#passwordReg").parent().removeClass("has-success");
									$("#passwordReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
									$("#passwordReg").val("");
									$("#passwordConfirmReg").parent().removeClass("has-success");
									$("#passwordConfirmReg").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
									$("#passwordConfirmReg").val("");
									$("#answer").parent().removeClass("has-success");
									$("#answer").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
									$("#answer").val("");
									
									$("#regBtn").removeAttr("disabled");
									alert("恭喜您，注册成功！");
								})
								
								
							}
						})
					}
					
				})
				
				return false;
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

					<form class="form-horizontal" id="loginForm">
						<div id="alert3" class="alert alert-danger" role="alert"
							style="display: none">！您输入的用户名与密码不匹配</div>
							<div id="alert4" class="alert alert-danger" role="alert"
							style="display: none">！该账户类型查无此人</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10 has-feedback">
								<input name="username" type="input" class="form-control"
									id="usernameLogin" placeholder="用户名" value="${sessionScope.username }"> <span></span> 
									<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="password" type="password" class="form-control"
									id="passwordLonin" placeholder="密码"> <span></span> <span
									id="editEmailHelpBlock" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">登录类型</label>
							<div class="col-sm-4">
								<select id="usertypeLogin" class="form-control" name="usertype">
									<option value="manager">管理员</option>
									<option value="emp">员工</option>
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

					<form class="form-horizontal" id="regForm">
						<div id="alert1" class="alert alert-danger" role="alert"
							style="display: none">！您输入的员工ID和姓名不匹配</div>
						<div id="alert2" class="alert alert-danger" role="alert"
							style="display: none">！该员工已经注册过账号</div>

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">员工ID</label>
							<div class="col-sm-10 has-feedback">
								<input name="empid" type="input" class="form-control"
									id="empIdReg" placeholder="ID"> <span></span> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10 has-feedback">
								<input name="name" type="input" class="form-control"
									id="empNameReg" placeholder="姓名"> <span></span> <span
									id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-10 has-feedback">
								<input name="username" type="input" class="form-control"
									id="usernameReg" placeholder="用户名由4到16位字母或数字组成"> <span></span>
								<span id="nameHelpBlock" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="password" type="password" class="form-control"
									id="passwordReg" placeholder="密码由4到16位字母或数字组成"> <span></span>
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10 has-feedback">
								<input name="passwordRe" type="password" class="form-control"
									id="passwordConfirmReg" placeholder="再次输入密码"> <span></span>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">密保问题</label>
							<div class="col-sm-10">
								<select id="questionSelect" class="form-control" name="question">
									<option>你印象最深刻的地方？</option>
									<option>你小学语文老师的名字？</option>
									<option>你大学的校名？</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="input" class="col-sm-2 control-label">密保答案</label>
							<div class="col-sm-10 has-feedback">
								<input name="answer" type="input" class="form-control"
									id="answer" placeholder="答案"> <span></span> <span
									class="help-block"></span>
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
	<div class="jumbotron"
		style="background-image: url('${APP_PATH }/pics/1111.jpg'); height:1000px">
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

			<a id="register" class="btn btn-primary btn-lg" href="#"
				role="button">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注册&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a id="login"
				class="btn btn-default btn-lg" href="#" role="button"
				style="background-color: rgba(0, 0, 0, 0); color: white;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;登录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</a>
		</div>
	</div>


</body>
</html>