package com.xuyan.crud.test;

import java.util.List;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.xuyan.crud.bean.Department;
import com.xuyan.crud.bean.Employee;
import com.xuyan.crud.bean.Notice;
import com.xuyan.crud.bean.User;
import com.xuyan.crud.bean.UserExample;
import com.xuyan.crud.bean.UserExample.Criteria;
import com.xuyan.crud.dao.DepartmentMapper;
import com.xuyan.crud.dao.EmployeeMapper;
import com.xuyan.crud.dao.NoticeMapper;
import com.xuyan.crud.dao.UserMapper;

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
	UserMapper userMapper;
	@Autowired
	NoticeMapper noticeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		
//		for(int i = 0 ; i < 300 ; i ++) {
//			Random random = new Random();
//			String gender = "";
//			String name = GenarateName.getName().toString();
//			if(random.nextInt(2) == 0) {
//				gender = "Male";
//			}else {
//				gender = "Female";
//			}
//			
//			mapper.insertSelective(new Employee(null, name, gender, name + "@gmail.com", 3));
//			
//		}
	}
	
	@Test
	public void testUser() {
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpidEqualTo(1);
		List<User> l = userMapper.selectByExample(example);
		for (User user : l) {
			System.out.println(user);
		}
	}
	
	@Test
	public void testNotice() {
		Notice notice = noticeMapper.selectByPrimaryKey(10);
		System.out.println(notice);
	}
	
}
