package com.xuyan.crud.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PowerController {
	
	// 登陆
	@RequestMapping("/login.do")
	public String logIn(@RequestParam("username") String username, 
			@RequestParam("empid") Integer id, 
			@RequestParam("usertype") String userType, HttpSession session) {
		// 根据Empid查询数据库账户类型，放到session中
		session.setAttribute("username", username);
		session.setAttribute("id", id);
		session.setAttribute("usertype", userType);
		session.setMaxInactiveInterval(3000);
		
		return "redirect:/notice/notices";
	}
	
	// 注销
	@RequestMapping("/logout.do")
	public String logOut(HttpSession session) {
		session.invalidate();
		return "redirect:/index.jsp";
	}
	
	
	
	// 去员工管理页面
	@RequestMapping("/tolist.do")
	public String toManagerList() {
		return "manager_empList";
	}
	
	// 去首页
	@RequestMapping("/toNotice.do")
	public String toManagerNotice() {
		return "redirect:/notice/notices";
	}
	
	// 去部门管理页面
	@RequestMapping("/toDeptList.do")
	public String toManagerDept() {
		return "redirect:/dept/getDepts";
	}
	
	// 去员工广场页面
	@RequestMapping("/toForum.do")
	public String toForum() {
		return "redirect:/article/articles";
	}
	
	// 去回复我的页面
	@RequestMapping("/toReply.do")
	public String toReply() {
		return "redirect:/comment/getAllByEmpid";
	}
}
