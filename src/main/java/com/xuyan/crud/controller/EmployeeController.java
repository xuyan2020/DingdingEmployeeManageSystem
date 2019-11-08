package com.xuyan.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuyan.crud.bean.Department;
import com.xuyan.crud.bean.Employee;
import com.xuyan.crud.bean.Msg;
import com.xuyan.crud.service.DepartmentService;
import com.xuyan.crud.service.EmployeeService;
import com.xuyan.crud.service.UserService;

@Controller
@RequestMapping("/emp")
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	@Autowired
	DepartmentService departmentService;
	@Autowired
	UserService userService;
	
	// 查询所有数据
	@ResponseBody
	@RequestMapping(value = "/emps", method = RequestMethod.GET)
	public Msg getAllWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		
		PageInfo page = new PageInfo(emps, 5);
		
		return Msg.success().add("pageInfo", page);
	}
	
	// 增加新数据
	@ResponseBody
	@RequestMapping(value = "/emps", method = RequestMethod.POST)
	public Msg getAllWithJson(@Valid Employee emp, BindingResult result) {
		if(result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			// 校验失败，应返回失败，在模态框中显示校验失败的错误信息
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError error : errors) {
				// getField() 错误的字段名，getDefaultMessage() 错误信息
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("errors", map);
		}else {
			employeeService.addEmp(emp);
			return Msg.success();
		}
		
	}
	
	// 根据ID查询数据
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	public Msg getEmpById(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		Employee employee = employeeService.getEmpById(id);
		
		return msg.success().add("employee", employee);
	}
	
	// 修改员工信息
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.PUT)
	public Msg updateEmpById(@Valid@PathVariable("id") Integer id, Employee emp, BindingResult result ) {
		Msg msg = new Msg();
		
		if(result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError error : errors) {
				map.put(error.getField(), error.getDefaultMessage());
			}
			return msg.fail().add("errors", map);
		}else {
			employeeService.updateEmpById(id, emp);
			return msg.success();
		}
		
	}
	
	// 删除单个员工信息
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		long count = userService.getUserByCount(id);
		if(count > 0) {
			userService.deleteUserById(id);
		}
		
		employeeService.deleteEmp(id);
		
		return msg.success();
	}
	
	// 删除多个员工信息
	@ResponseBody
	@RequestMapping(value = "/emps/{ids}", method = RequestMethod.DELETE)
	public Msg delEmps(@PathVariable("ids") String ids) {
		Msg msg = new Msg();
		String[] str = ids.split(",");
		for (String id : str) {
			long count = userService.getUserByCount(Integer.parseInt(id));
			if(count > 0) {
				userService.deleteUserById(Integer.parseInt(id));
			}
			employeeService.deleteEmp(Integer.parseInt(id));
		}
		
		return msg.success();
	}

	// 校验姓名是否存在
	@ResponseBody
	@RequestMapping("/empByName")
	public Msg getEmpCountByName(@RequestParam("name") String name) {
		Msg msg = new Msg();
		long l = employeeService.getEmpCountByName(name);
		
		return msg.success().add("count", l);
		
	}
	
	// 根据姓名模糊查询
	@ResponseBody
	@RequestMapping("/empByLikeName")
	public Msg getEmpByLikeName(@RequestParam("name") String name,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		Msg msg = new Msg();
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getEmpByLikeName(name);
		
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	

	
	
	@RequestMapping("/toList")
	public String toList() {
		return "manager_empList";
	}
	@RequestMapping("/empsPre")
	public String getAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Map<String , Object> map) {
		/*
		 * 引入PageHelper插件
		 * 在查询之前，只需要调用PageHelper.startPage(startPage, pageSize);
		 * @Param
		 * startPage：传入页码
		 * pageSize：每页的大小
		 */
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		/*
		 * 使用PageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
		 * 封装了详细的分页信息，包括查询出来的数据
		 * 可以在集合后面传入连续显示的页数，在目标视图可以使用getNavigatepageNums()方法查看当前取出的页数
		 */
		PageInfo page = new PageInfo(emps, 5);
		
		map.put("pageInfo", page);
		return "list";
	}
	
}
