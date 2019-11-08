package com.xuyan.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xuyan.crud.bean.Msg;
import com.xuyan.crud.bean.User;
import com.xuyan.crud.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	// 根据ID查询数据
	@ResponseBody
	@RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
	public Msg getUserById(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		User user = userService.getUserById(id);
		
		return msg.success().add("user", user);
	}
	
	// 根据ID校验数据是否存在
	@ResponseBody
	@RequestMapping("/userById")
	public Msg getUserCountById(@RequestParam("id") Integer id) {
		Msg msg = new Msg();
		long count = userService.getUserByCount(id);
		
		return msg.success().add("count", count);
	}
	
	// 添加新账户
	@ResponseBody
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public Msg addUser(User user) {
		Msg msg = new Msg();
		userService.addUser(user);
		
		return msg.success();
	}
	
	// 根据用户名获取账户数据
	@ResponseBody
	@RequestMapping("/getUserByUsername")
	public Msg getUserByUsername(@RequestParam("name") String name) {
		Msg msg = new Msg();
		User user = userService.getUserByUsername(name);
		
		return msg.success().add("user", user);
	}
	
	// 根据ID更新传入的部分（或全部）数据
	@ResponseBody
	@RequestMapping(value = "/updateUserType/{id}", method = RequestMethod.PUT)
	public Msg updateUserById(@PathVariable("id") Integer id, User user) {
		Msg msg = new Msg();
		user.setEmpid(id);
		
		userService.updateUserById(user);
		
		return msg.success();
	}
	
	
	
}
