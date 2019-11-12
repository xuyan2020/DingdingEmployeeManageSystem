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
		
		return "redirect:/toNotice.do";
	}
	
	// 注销
	@RequestMapping("/logout.do")
	public String logOut(HttpSession session) {
		session.setAttribute("id", null);
		session.invalidate();
		session.setMaxInactiveInterval(0);
		return "redirect:/index.jsp";
	}
	
	
	
	// 去员工管理页面
	@RequestMapping("/tolist.do")
	public String toManagerList(HttpSession session) {
		if(session.getAttribute("id") != null) {
			if(session.getAttribute("usertype").equals("manager")) {
				return "/manager_empList";
			}else {
				return "/emp_empList";
			}
		}else {
			return "redirect:/index.jsp";
		}
		
		
	}
	
	// 去首页
	@RequestMapping("/toNotice.do")
	public String toManagerNotice(HttpSession session) {
		if(session.getAttribute("id") != null) {
			String empType = (String) session.getAttribute("usertype");
			if(empType.equalsIgnoreCase("manager")) {
				return "redirect:/notice/notices";
			}else {
				return "redirect:/notice/emp_notice";
			}
		}else {
			return "redirect:/index.jsp";
		}
		
	}
	
	// 去部门管理页面
	@RequestMapping("/toDeptList.do")
	public String toManagerDept(HttpSession session) {
		if(session.getAttribute("id") != null) {
			return "redirect:/dept/getDepts";
		}else {
			return "redirect:/index.jsp";
		}
		
	}
	
	// 去员工广场页面
	@RequestMapping("/toForum.do")
	public String toForum(HttpSession session) {
		
		if(session.getAttribute("id") != null) {
			return "redirect:/article/articles";
		}else {
			return "redirect:/index.jsp";
		}
		
	}
	
	// 去回复我的页面
	@RequestMapping("/toReply.do")
	public String toReply(HttpSession session) {
		if(session.getAttribute("id") != null) {
			return "redirect:/comment/getAllByEmpid";
		}else {
			return "redirect:/index.jsp";
		}
		
	}
}
