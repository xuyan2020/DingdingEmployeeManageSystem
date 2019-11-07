package com.xuyan.crud.test;

import java.util.Random;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.xuyan.crud.bean.Department;
import com.xuyan.crud.bean.Employee;
import com.xuyan.crud.dao.DepartmentMapper;
import com.xuyan.crud.dao.EmployeeMapper;

/*
 * 使用SpringTest测试
 * 1. 导入SpringTest模块（在Maven中配置）
 * 2. @ContextConfiguration指定Spring配置文件的位置
 * 3. 直接autowired要使用的组件即可
 * 
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		
		for(int i = 0 ; i < 300 ; i ++) {
			Random random = new Random();
			String gender = "";
			String name = GenarateName.getName().toString();
			if(random.nextInt(2) == 0) {
				gender = "Male";
			}else {
				gender = "Female";
			}
			
			mapper.insertSelective(new Employee(null, name, gender, name + "@gmail.com", 3));
			
		}
       
		
		
	}
	
}
