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
		<style type="text/css">
			body{ 
				padding-top: 70px; 
			}
		</style>
		
		<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />

		<script type="text/javascript">
			var switchEmpsAndSearch = 0;
			var searchStr = null;
			
			/* 第一次进入页面跳转到第一页 */
			$(function() {
				toPage(1);
			})
			/* AJAX页面跳转函数 */
			function toPage(pn) {
				if(switchEmpsAndSearch == 0){
					var url = "${APP_PATH}/emp/emps";
					var args = {
						"pn": pn
					};
					$.get(url, args, function(result) {
						//1.解析显示员工数据
						build_emps(result);
						//2.解析显示分页数据
						build_pages(result);
					})
				}else if(switchEmpsAndSearch == 1){
					console.log(searchStr);
					var url = "${APP_PATH}/emp/empByLikeName";
					var args = {
						"name": "%" + searchStr + "%",
						"pn": pn
					};
					$.get(url, args, function(result) {
						$("#searchForm").val("");
						//1.解析显示员工数据
						build_emps(result);
						//2.解析显示分页数据
						build_pages(result);
					})
				}
			}
			/* 产生员工详细信息 */
			function build_emps(result) {
				$("tbody").empty();
				var empList = result.extend.pageInfo.list;
				$.each(empList, function(index, item) {
					var checkBoxNode = $("<td></td>")
						.append($("<input/>").attr("type", "checkbox").attr("name", item.lastName).val(item.id).addClass("checkBoxs"));
					var idNode = $("<td></td>").append(item.id);
					var nameNode = $("<td></td>").append(item.lastName);
					var genderNode = $("<td></td>").append(item.gender);
					var emailNode = $("<td></td>").append(item.email);
					var deptidNode = $("<td></td>").append(item.deptid);
					var deptnameNode = $("<td></td>").append(item.department.deptname);

					var addBtn = $("<button></button>").attr("value", item.id).addClass("btn btn-success btn-sm editEmpBtn")
						.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
						.append(" ").append("编辑");
					var accountBtn = $("<button></button>").attr("value", item.id).attr("name", item.lastName)
						.addClass("btn btn-primary btn-sm accountEmpBtn")
						.append($("<span></span>").addClass("glyphicon glyphicon-user"))
						.append(" ").append("账户");
					var deleteBtn = $("<button></button>").attr("value", item.id).attr("name", item.lastName)
						.addClass("btn btn-danger btn-sm delEmpBtn")
						.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
						.append(" ").append("删除");
					var operateNode = $("<td></td>").append(addBtn).append(" ").append(accountBtn).append(" ").append(deleteBtn);

					var newTrNode = $("<tr></tr>").append(checkBoxNode).append(idNode).append(nameNode)
						.append(genderNode).append(emailNode).append(deptidNode)
						.append(deptnameNode).append(operateNode);
					$("tbody").append(newTrNode);
				})
			}
			/* 产生页码等信息 */
			function build_pages(result) {
				$("#p1").empty();
				$("#p2").empty();
				var pageInfo = result.extend.pageInfo;
				$("#p1").text("当前第" + pageInfo.pageNum + "页，共" + pageInfo.pages + "页，共查询到" + pageInfo.total + "条记录");

				var ulNode = $("<ul></ul>").addClass("pagination");

				var firstPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("首页"));
				var prePageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("&laquo;"));
				var nextPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("&raquo;"));
				var lastPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("尾页"));

				ulNode.append(firstPageLi);
				if (pageInfo.isFirstPage == false) {
					$(ulNode).append(prePageLi);
				}

				$.each(pageInfo.navigatepageNums, function(index, item) {
					var numNode = $("<li></li>").append($("<a></a>").attr("href", "#").text(item));
					if (pageInfo.pageNum == item) {
						numNode.addClass("active");
					}
					ulNode.append(numNode);
					$(numNode).click(function() {
						toPage(item);
					})
				})

				if (pageInfo.isLastPage == false) {
					$(ulNode).append(nextPageLi);
				}
				ulNode.append(lastPageLi);

				$("#p2").append($("<nav></nav>").attr("aria-label", "Page navigation").append(ulNode));

				$(firstPageLi).click(function() {
					toPage(1);
				})
				$(prePageLi).click(function() {
					toPage(pageInfo.pageNum - 1);
				})
				$(nextPageLi).click(function() {
					toPage(pageInfo.pageNum + 1);
				})
				$(lastPageLi).click(function() {
					toPage(pageInfo.pages);
				})
			}

			/* 新增员工操作 */
			$(function() {
				/* 打开模态框 */
				$("#addEmpModalBtn").click(function() {
					$("#addEmpModal").modal({
						/* 点击背景不关闭 */
						backdrop: "static"
					});

					/* ajax获取部门信息 */
					var url = "${APP_PATH}/emp/depts";
					var args = {
						"date": new Date()
					};
					$.get(url, args, function(result) {
						var depts = result.extend.depts;
						$("#select").empty();
						$.each(depts, function(index, item) {
							$("#select").append($("<option></option>").text(item.deptname).val(item.deptid));
						})
					})
				})


				/* 点击模态框保存发送请求 */
				$("#saveNewEmp").click(function() {
					$("#saveNewEmp").attr("disabled", "disabled");
					setTimeout(function() {
						$("#saveNewEmp").removeAttr("disabled");
					},1500)
					/* 校验姓名格式 */
					var name = $("#newName").val();
					var nameReg = /^[a-zA-Z0-9_]{3,15}$/;
					if (!nameReg.test(name)) {
						$("#newName").parent().removeClass("has-success");
						$("#newName").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
						$("#newName").parent().addClass("has-error");
						$("#newName").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
						$("#nameHelpBlock").text("name必须是3到15位英文字母");
						return false;
					} else {
						$("#newName").parent().removeClass("has-error");
						$("#newName").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
						$("#newName").parent().addClass("has-success");
						$("#newName").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
						$("#nameHelpBlock").text("此name可用");
					}
					/* 校验姓名是否存在 */
					var url = "${APP_PATH}/emp/empByName";
					var args = {
						"name": $("#newName").val()
					};
					$.get(url, args, function(result) {
						if (result.extend.count > 0) {
							$("#newName").parent().removeClass("has-success");
							$("#newName").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
							$("#newName").parent().addClass("has-error");
							$("#newName").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
							$("#nameHelpBlock").text("此name已经入库，请勿重复入库");
							return false;
						} else {
							$("#newName").parent().removeClass("has-error");
							$("#newName").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
							$("#newName").parent().addClass("has-success");
							$("#newName").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
							$("#nameHelpBlock").text("此name可用");
						}
					})
					/* 校验邮箱格式 */
					var email = $("#newEmail").val();
					var emailReg = /^([A-Za-z0-9_\-\.\u4e00-\u9fa5])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,8})$/;
					emailReg.test(email);
					if (!emailReg.test(email)) {
						$("#newEmail").parent().removeClass("has-success");
						$("#newEmail").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
						$("#newEmail").parent().addClass("has-error");
						$("#newEmail").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
						$("#emailHelpBlock").text("邮箱格式不正确");
						return false;
					} else {
						$("#newEmail").parent().removeClass("has-error");
						$("#newEmail").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
						$("#newEmail").parent().addClass("has-success");
						$("#newEmail").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
						$("#emailHelpBlock").text("邮箱格式正确");
					}
					$("#saveNewEmp").attr("disabled", "disabled");
					/* 如果没有问题则提交 */
					var url = "${APP_PATH}/emp/emps";
					var args = $("#newEmpForm").serialize();
					$.post(url, args, function(result) {
						/* 后端校验通过 */
						if (result.code == 200) {
							$("#addEmpModal").modal("hide");
							$("#saveNewEmp").removeAttr("disabled", "disabled");
							/* 移除所有校验效果 */
							$("#newName").val("");
							$("#newName").parent().removeClass("has-success");
							$("#newName").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
							$("#nameHelpBlock").text("");
							$("#newEmail").val("");
							$("#newEmail").parent().removeClass("has-success");
							$("#newEmail").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
							$("#emailHelpBlock").text("");
							toPage(1);
						} else {
							/* 后端校验未通过 */
							if (result.extend.errors.lastName != undefined) {
								alert(result.extend.errors.lastName);
							}
							if (result.extend.errors.email != undefined) {
								alert(result.extend.errors.email);
							}
						}

					})
				})

			})

			/* 定义一个变量保存要修改的员工的ID */
			var editID = 0;
			/* 修改、删除、查找操作 */
			$(function() {
				/* 打开模态框 */
				$(document).on("click", ".editEmpBtn", function() {
					$("#editEmpModal").modal({
						/* 点击背景不关闭 */
						backdrop: "static"
					});

					/* 每次打开模态框都即时更新要修改员工的ID */
					editID = $(this).val();

					/* ajax获取部门信息 */
					var url = "${APP_PATH}/dept/depts";
					var args = {
						"date": new Date()
					};
					$.get(url, args, function(result) {
						var depts = result.extend.depts;
						$("#editSelect").empty();
						$.each(depts, function(index, item) {
							$("#editSelect").append($("<option></option>").text(item.deptname).val(item.deptid));
						})
					})


					/* 获取员工信息并回显 */
					var url = "${APP_PATH}/emp/emp/" + $(this).val();
					var args = {
						"date": new Date()
					};
					$.get(url, args, function(result) {
						var emp = result.extend.employee;
						$("#editName").text(emp.lastName);
						$("#editInputName").val(emp.lastName);
						if (emp.gender == "Male") {
							$("#editFemale").attr("checked", false);
							$("#editMale").attr("checked", true);
						} else {
							$("#editMale").attr("checked", false);
							$("#editFemale").attr("checked", true);
						}
						$("#editEmail").val(emp.email);
						$("#editSelect option").each(function(index, item) {
							if ($(item).val() == emp.deptid) {
								$(item).attr("selected", true);
							} else {
								$(item).attr("selected", false);
							}
						})
					})

					$("#editEmp").click(function() {
						$("#editEmp").attr("disabled", "disabled");
						setTimeout(function() {
							$("#editEmp").removeAttr("disabled");
						},1000)
						/* 校验邮箱格式 */
						var email = $("#editEmail").val();
						var emailReg = /^([A-Za-z0-9_\-\.\u4e00-\u9fa5])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,8})$/;
						emailReg.test(email);
						if (!emailReg.test(email)) {
							$("#editEmail").parent().removeClass("has-success");
							$("#editEmail").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
							$("#editEmail").parent().addClass("has-error");
							$("#editEmail").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
							$("#editEmailHelpBlock").text("邮箱格式不正确");
							return false;
						} else {
							$("#editEmail").parent().removeClass("has-error");
							$("#editEmail").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
							$("#editEmail").parent().addClass("has-success");
							$("#editEmail").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
							$("#editEmailHelpBlock").text("邮箱格式正确");
						}
						$("#editEmp").attr("disabled", "disabled");
						/* 如果没有问题则提交 */
						var url = "${APP_PATH}/emp/emp/" + editID;
						var args = $("#editEmpForm").serialize() + "&_method=PUT";
						$.post(url, args, function(result) {
							/* 后端校验通过 */
							if (result.code == 200) {
								$("#editEmpModal").modal("hide");
								$("#editEmp").removeAttr("disabled", "disabled");
								/* 移除所有校验效果 */
								$("#editEmail").val("");
								$("#editEmail").parent().removeClass("has-success");
								$("#editEmail").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
								$("#editEmailHelpBlock").text("");
								toPage(1);
							} else {
								/* 后端校验未通过 */
								if (result.extend.errors.email != undefined) {
									alert(result.extend.errors.email);
								}
							}

						})
					})

				})

				/* 删除单个员工 */
				$(document).on("click", ".delEmpBtn", function() {
					var name = $(this).attr("name");
					var id = $(this).val();

					var flag = confirm("确定删除" + name + "的信息吗？");
					if (flag) {
						var url = "${APP_PATH}/emp/emp/" + id;
						var args = {
							"date": new Date(),
							"_method": "DELETE"
						};
						$.post(url, args, function(result) {
							toPage(1);
						})
					}
					return false;
				})
				
				/* 查看员工账户 */
				
				$(document).on("click", ".accountEmpBtn", function() {
					
					var userId = $(this).val();
					var lastName = $(this).attr("name");
					var url = "${APP_PATH }/user/user/" + userId;
					var args = {"date" : new Date()};
					$.get(url, args, function(result) {
						if(result.extend.user != null){
							$("#accountModal").modal({
								/* 点击背景不关闭 */
								backdrop: "static"
							});
							var dbUsername = result.extend.user.username;
							var dbPassword = result.extend.user.password;
							var dbQuestion = result.extend.user.question;
							var dbAnswer = result.extend.user.answer;
							var dbRegtime = result.extend.user.regtime;
							var dbUsertype = result.extend.user.usertype;
							$("#accountModalLabel").text(lastName + "的账户信息")
							$("#empUserId").text(userId);
							$("#empUsername").text(dbUsername);
							$("#empUserPassword").text(dbPassword);
							$("#empUserQuestion").text(dbQuestion);
							$("#empUserAnswer").text(dbAnswer);
							$("#empUserRegTime").text(dbRegtime);
							/* 将账户类型选中 */
							$("#" + dbUsertype).prop("checked", true);
							/* 点击账户类型区域进行判断修改账户类型按钮是否改变状态 */
							$("#switchEditTypeBtn").click(function() {
								if($("#" + dbUsertype).prop("checked") == true){
									$("#editUserType").attr("disabled", "disabled");
								}else {
									$("#editUserType").removeAttr("disabled", "disabled");
								}
							})
							
							/* 对切换账户类型按钮添加监视 */
							$("#editUserType").click(function() {
								var userType = null;
								if(dbUsertype == "manager"){
									userType = "emp";
								}else {
									userType = "manager";
								}
								var url = "${APP_PATH }/user/updateUserType/" + userId;
								var args = {"_method" : "PUT",
											"usertype" : userType};
								$.post(url, args, function(result) {
									alert("修改成功！");
									$("#editUserType").attr("disabled", "disabled");
									$("#accountModal").modal("hide");
								})
							})
							
						}else {
							alert("该用户还没有创建账户")
						}
					})
					return false;
				})
				$("#accountConfirmBtn").click(function() {
					$("#accountModal").modal("hide");
				})			
				

				/* 批量删除员工 */
				/* 1.全选/全不选按钮 */
				$(document).on("click", "#checkBoxAll", function() {
					if ($("#checkBoxAll").prop("checked") == true) {
						$(".checkBoxs").each(function(index, item) {
							$(item).prop("checked", true);
						})
					} else {
						$(".checkBoxs").each(function(index, item) {
							$(item).prop("checked", false);
						})
					}
				})
				/* 2.单击删除按钮操作 */
				$("#delEmpModalBtn").click(function() {
					var list = [];
					var nameList = [];
					$(".checkBoxs").each(function(index, item) {
						if ($(item).prop("checked") == true) {
							list.push($(this).val());
							nameList.push($(this).attr("name"));
						}
					})
					if (list.length == 0) {
						alert("没有选中任何员工信息！");
						return false;
					}
					var flag = confirm("确定删除" + nameList + "的信息吗？");
					if (flag) {
						var url = "${APP_PATH}/emp/emps/" + list;
						var args = {
							"date": new Date(),
							"_method": "DELETE"
						};
						$.post(url, args, function(result) {
							toPage(1);
						})
					}
					return false;
				})
			
				/* 模糊查找 */
				$("#searchBtn").click(function(){
					var searchContent = $("#searchForm").val();
					var nameReg = /[^0-9a-zA-Z_-]+/;
					if (nameReg.test(searchContent) || searchContent.trim() == "") {
						$("#searchForm").parent().removeClass("has-success");
						$("#searchForm").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
						$("#searchForm").parent().addClass("has-error");
						$("#searchForm").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
						$("#searchHelpBlock").text("查找内容不允许有特殊字符");
						return false;
					} else {
						$("#searchForm").parent().removeClass("has-error");
						$("#searchForm").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
						$("#searchHelpBlock").text("");
						switchEmpsAndSearch = 1;
						searchStr = searchContent;
					}
					
					
					toPage(1);
					/* 查找相应员工信息 */
					
				})
			})
		</script>

	</head>
	<body>


		<!-- 员工添加的模态框 -->
		<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">添加员工</h4>
					</div>
					<div class="modal-body">

						<form class="form-horizontal" id="newEmpForm">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">Name</label>
								<div class="col-sm-10 has-feedback">
									<input name="lastName" type="input" class="form-control" id="newName" placeholder="3个以上15个以下字母组成">
									<span></span>
									<span id="nameHelpBlock" class="help-block"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Gender</label>
								<div class="col-sm-10">
									<label class="radio-inline">
										<input type="radio" name="gender" id="inlineRadio1" value="Male" checked="checked">
										Male
									</label>
									<label class="radio-inline">
										<input type="radio" name="gender" id="inlineRadio2" value="Female">
										Female
									</label>
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Email</label>
								<div class="col-sm-10 has-feedback">
									<input name="email" type="input" class="form-control" id="newEmail" placeholder="邮箱地址">
									<span></span>
									<span id="emailHelpBlock" class="help-block"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Department</label>
								<div class="col-sm-4">
									<select id="select" class="form-control" name="deptid">

									</select>
								</div>
							</div>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="saveNewEmp">Save</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 员工修改的模态框 -->
		<div class="modal fade" id="editEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改信息</h4>
					</div>
					<div class="modal-body">

						<form class="form-horizontal" id="editEmpForm">
							<div class="form-group">
								<label class="col-sm-2 control-label">Name</label>
								<div class="col-sm-10">
									<p id="editName" class="form-control-static"></p>
									<input type="hidden" name="lastName" id="editInputName" value="">
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Gender</label>
								<div class="col-sm-10">
									<label class="radio-inline">
										<input type="radio" name="gender" id="editMale" value="Male" checked="checked">
										Male
									</label>
									<label class="radio-inline">
										<input type="radio" name="gender" id="editFemale" value="Female">
										Female
									</label>
								</div>
							</div>

							<div class="form-group">
								<label for="input" class="col-sm-2 control-label">Email</label>
								<div class="col-sm-10 has-feedback">
									<input name="email" type="input" class="form-control" id="editEmail" placeholder="邮箱地址">
									<span></span>
									<span id="editEmailHelpBlock" class="help-block"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Department</label>
								<div class="col-sm-4">
									<select id="editSelect" class="form-control" name="deptid">

									</select>
								</div>
							</div>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="editEmp">Edit</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 查看员工账户的模态框 -->
		<div class="modal fade" id="accountModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="accountModalLabel">员工账户信息</h4>
					</div>
					<div class="modal-body">
	
						<form class="form-horizontal" id="userForm">
							<div  class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">员工ID</label>
							<div class="col-sm-10">
								<p id="empUserId" class="form-control-static"></p>
							</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
								<div class="col-sm-10">
									<p id="empUsername" class="form-control-static"></p>
									<input type="hidden" name="lastName" id="editInputName" value="">
								</div>
							</div>
	
							<div class="form-group">
								<label for="input" class="col-sm-2 control-label">密码</label>
								<div class="col-sm-10">
									<p id="empUserPassword" class="form-control-static"></p>
									<input type="hidden" name="lastName" id="editInputName" value="">
								</div>
							</div>
	
							<div class="form-group">
								<label for="input" class="col-sm-2 control-label">密保问题</label>
								<div class="col-sm-10">
									<p id="empUserQuestion" class="form-control-static"></p>
									<input type="hidden" name="lastName" id="editInputName" value="">
								</div>
							</div>
							<div class="form-group">
								<label for="input" class="col-sm-2 control-label">密保答案</label>
								<div class="col-sm-10">
									<p id="empUserAnswer" class="form-control-static"></p>
									<input type="hidden" name="lastName" id="editInputName" value="">
								</div>
							</div>
							<div class="form-group">
								<label for="input" class="col-sm-2 control-label">注册时间</label>
								<div class="col-sm-10">
									<p id="empUserRegTime" class="form-control-static"></p>
									<input type="hidden" name="lastName" id="editInputName" value="">
								</div>
							</div>
							<div class="form-group" id="switchEditTypeBtn">
								<label for="input" class="col-sm-2 control-label">用户类型</label>
								<div class="col-sm-6">
									<label class="radio-inline"> 
									<input type="radio"
										name="inlineRadioOptions" id="manager" value="manager">
										管理员
									</label> <label class="radio-inline"> <input type="radio"
										name="inlineRadioOptions" id="emp" value="emp">
										员工
									</label>
								</div>
								<div class="col-sm-4">
									<button id="editUserType" type="button" class="btn btn-danger btn-sm" disabled="disabled">
										修改用户类型
									</button>
								</div>
							</div>
						</form>
	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="accountConfirmBtn">确定</button>
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
							<li><a href="${APP_PATH}/toNotice.do">首页 <span class="sr-only">(current)</span></a></li>
							<li class="active"><a href="${APP_PATH}/toList.do">员工管理</a></li>
							<li>
								<a href="#">部门管理</a>
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
			<div class="row">
				<!-- 标题 -->
				<div class="page-header">
					<h1>叮叮员工管理系统<small>CRUD</small></h1>
				</div>
			</div>

			
			<!-- 按钮 -->
			<div class="row">
				<ul class="nav navbar-nav">
					<div>
						<button type="button" class="btn btn-default" id="addEmpModalBtn">添加</button>
						<button type="button" class="btn btn-default" id="delEmpModalBtn">删除</button>
					</div>
				</ul>
				<ul class="nav navbar-nav navbar-right" >
					<div style="border: 0px, 0px;">
						<form class="navbar-form navbar-left">
							<div class="form-group">
								<button id="searchBtn" type="submit" class="btn btn-default">查找</button>
								<input id="searchForm" type="text" class="form-control" placeholder="可根据姓名进行模糊查找">
								<span></span>
								<span id="searchHelpBlock" class="help-block"></span>
								
							</div>
							
						</form>
					</div>
				</ul>	
				
			</div>
			<!-- 数据 -->
			<div class="row">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="checkBoxAll" />
							</th>
							<th>#</th>
							<th>Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>DeptID</th>
							<th>DeptName</th>
							<th>Operation</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>
			<!-- 分页信息 -->
			<div class="row">
				<ul class="nav navbar-nav">
					<br />
					<div id="p1" class="">
				
					</div>
				</ul>
				<ul class="nav navbar-nav navbar-right" >
					<div id="p2" class="" style="border: 0px, 0px;">
					
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
