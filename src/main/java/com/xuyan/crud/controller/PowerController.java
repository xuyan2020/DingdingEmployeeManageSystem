package com.xuyan.crud.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PowerController {
	
	@RequestMapping("logout.do")
	public String logOut(HttpSession session) {
		session.invalidate();
		return "redirect:/index.jsp";
	}
	
	// 去员工管理页面
	@RequestMapping("tolist.do")
	public String toList(@RequestParam("username") String username, 
			@RequestParam("empid") Integer id, HttpSession session) {
		session.setAttribute("username", username);
		session.setAttribute("id", id);
		session.setMaxInactiveInterval(3000);
		return "manager_empList";
	}
}
