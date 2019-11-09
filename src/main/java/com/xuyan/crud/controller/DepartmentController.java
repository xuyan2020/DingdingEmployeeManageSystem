package com.xuyan.crud.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
	
	// 获取全部部门信息
	@RequestMapping("/getDepts")
	public String depts(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Map<String, Object> map, 
			HttpSession session) {
		PageHelper.startPage(pn, 5);
		List<Department> depts = departmentService.getAll();
		PageInfo page = new PageInfo(depts, 5);
		map.put("pageInfo", page);
		
		if(session.getAttribute("usertype").equals("manager")) {
			return "manager_deptList";
		}else {
			return "emp_deptList";
		}
	}
	
	// 添加新部门
	@ResponseBody
	@RequestMapping(value = "/dept", method = RequestMethod.POST)
	public Msg addNewDept(Department department) {
		Msg msg = new Msg();
		departmentService.addNewDept(department);
		return msg.success();
	}
	
	// 根据ID查找部门信息
	@ResponseBody
	@RequestMapping(value = "/dept/{id}", method = RequestMethod.GET)
	public Msg getMsgById(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		Department department = departmentService.getDeptById(id);
		return msg.success().add("dept", department);
	}
	
	// 修改部门信息
	@ResponseBody
	@RequestMapping(value = "/dept/{id}", method = RequestMethod.PUT)
	public Msg updateDeptById(@PathVariable("id") Integer id, Department department) {
		Msg msg = new Msg();
		department.setDeptid(id);
		departmentService.updateDeptById(department);
		return msg.success();
	}
}
