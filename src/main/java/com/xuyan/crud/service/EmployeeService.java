package com.xuyan.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xuyan.crud.bean.Employee;
import com.xuyan.crud.bean.EmployeeExample;
import com.xuyan.crud.bean.EmployeeExample.Criteria;
import com.xuyan.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void addEmp(Employee emp) {
		employeeMapper.insertSelective(emp);
		
	}

	public long getEmpCountByName(String name) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andLastnameEqualTo(name);
		return employeeMapper.countByExample(example);
		
	}

	public Employee getEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id).get(0);
		
	}

	public void updateEmpById(Integer id, Employee emp) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(id);
		employeeMapper.updateByExample(emp, example);
	}

	public void deleteEmp(Integer id) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(id);
		employeeMapper.deleteByExample(example);
		
	}

	public List<Employee> getEmpByLikeName(String name) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andLastnameLike(name);
		List<Employee> list = employeeMapper.selectByExampleWithDept(example);
		return list;
	}

	public long getCountByDepId(Integer depid) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andDeptidEqualTo(depid);
		long l = employeeMapper.countByExample(example);
		return l;
	}
}
