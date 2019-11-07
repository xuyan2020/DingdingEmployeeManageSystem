package com.xuyan.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xuyan.crud.bean.Department;
import com.xuyan.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getAll(){
		return departmentMapper.selectByExample(null);
	}
	
}
