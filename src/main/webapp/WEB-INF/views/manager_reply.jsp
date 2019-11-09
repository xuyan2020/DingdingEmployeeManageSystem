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
		
		
		/* 删除评论 */
		$(document).on("click", ".delNoticeBtn", function(){
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
		
	})
</script>
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
						<li ><a href="${APP_PATH}/toNotice.do">首页 <span class="sr-only">(current)</span></a></li>
						<li ><a href="${APP_PATH}/tolist.do">员工管理</a></li>
						<li">
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
				<h1>叮叮员工管理系统<small>&nbsp;&nbsp;员工广场</small></h1>
			</div>
		</div>
		<div class="row">
			
			<ul class="nav navbar-nav navbar-right" >
				<div style="border: 0px, 0px;">
					<form class="navbar-form navbar-left">
						<div class="form-group">
							<!-- 
							<button type="button" class="btn btn-default" id="addNoticeBtn">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								发布新帖子
							</button>
							 -->
						</div>
						
					</form>
				</div>
			</ul>	
		</div>
		<div class="row">
			<c:forEach items="${pageInfo.list }" var="comment">
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<a href="#" class="titleA" value="${comment.id }"> 
									${comment.content }
								</a>
							</h3>
							<h5>发布人: ${comment.empid }</h5>
							<h5>发布时间: <fmt:formatDate value="${comment.publishtime }"  pattern="yyyy-MM-dd HH:mm:ss"/></h5>
							
							<h5>
								
							</h5>
							
							<a href="#" value="${comment.id }" class="delNoticeBtn">删除</a>
							
						</div>
						<!-- 
						<div class="panel-collapse collapse in">
							<div class="panel-body">
								
								
							</div>
						</div>
						 -->
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
								<li><a href="${APP_PATH }/comment/getAllByEmpid?pn=1">首页</a></li>
								<c:if test="${pageInfo.hasPreviousPage }">
									<li>
										<a href="${APP_PATH }/comment/getAllByEmpid?pn=${pageInfo.pageNum - 1 }" aria-label="Previous"> 
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
								</c:if>
								
								<c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
									<c:if test="${page_num == pageInfo.pageNum }">
										<li class="active"><a href="#">${page_num }</a></li>
									</c:if>
									<c:if test="${page_num != pageInfo.pageNum }">
										<li><a href="${APP_PATH }/comment/getAllByEmpid?pn=${page_num }">${page_num }</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${pageInfo.hasNextPage }">
									<li>
										<a href="${APP_PATH }/comment/getAllByEmpid?pn=${pageInfo.pageNum + 1 }" aria-label="Next"> 
											<span aria-hidden="true">&raquo;</span>
										</a>
									</li>
								</c:if>
								
								<li><a href="${APP_PATH }/comment/getAllByEmpid?pn=${pageInfo.pages }">尾页</a></li>
							</ul>
						</nav>
					</div>
				</ul>		
			</div>
			
		</div>
		
	</div>

	
</body>
</html>