package com.xuyan.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xuyan.crud.bean.Department;
import com.xuyan.crud.bean.Msg;
import com.xuyan.crud.service.DepartmentService;

@Controller
@RequestMapping("/dept")
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	// 获取全部部门信息
	@ResponseBody
	@RequestMapping(value = "/depts", method = RequestMethod.GET)
	public Msg getDepts() {
		Msg msg = new Msg();
		List<Department> depts = departmentService.getAll();
		
		return Msg.success().add("depts", depts);
		
	}
	
}
