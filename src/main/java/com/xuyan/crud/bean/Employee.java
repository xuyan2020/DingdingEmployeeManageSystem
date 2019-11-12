package com.xuyan.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer id;
    
    @Pattern(regexp = "^[a-zA-Z0-9_]{3,15}$", 
    		message = "用户名必须是3到15位英文字母")
    private String lastName;

    private String gender;
    
    @Pattern(regexp = "^([A-Za-z0-9_\\-\\.\\u4e00-\\u9fa5])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,8})$", 
    		message = "邮箱格式不正确")
    private String email;

    private Integer deptid;
    
    private Department department;
    
    

    public Employee() {
		super();
	}

	public Employee(Integer id, String lastname, String gender, String email, Integer deptid) {
		super();
		this.id = id;
		this.lastName = lastname;
		this.gender = gender;
		this.email = email;
		this.deptid = deptid;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastname) {
        this.lastName = lastname == null ? null : lastname.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptid() {
        return deptid;
    }

    public void setDeptid(Integer deptid) {
        this.deptid = deptid;
    }

	@Override
	public String toString() {
		return "Employee [id=" + id + ", lastname=" + lastName + ", gender=" + gender + ", email=" + email + ", deptid="
				+ deptid + ", department=" + department + "]";
	}
    
    
}