package com.xuyan.crud.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xuyan.crud.bean.User;
import com.xuyan.crud.bean.UserExample;
import com.xuyan.crud.bean.UserExample.Criteria;
import com.xuyan.crud.dao.UserMapper;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;

	public User getUserById(Integer id) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpidEqualTo(id);
		List<User> user = userMapper.selectByExample(example);
		if(user.size() != 0) {
			return user.get(0);
		}else {
			return null;
		}
		
		
	}

	public long getUserByCount(Integer id) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpidEqualTo(id);
		long l = userMapper.countByExample(example);
		return l;
		
	}

	public void addUser(User user) {
		user.setRegtime(new Date());
		userMapper.insertSelective(user);
	}

	public User getUserByUsername(String name) {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(name);
		User user = userMapper.selectByExample(example).get(0);
		return user;
			
	}

	public void updateUserById(User user) {
		userMapper.updateByPrimaryKeySelective(user);
		
	}

	public void deleteUserById(Integer id) {
		userMapper.deleteByPrimaryKey(id);
		
	}
	
	
	
}
