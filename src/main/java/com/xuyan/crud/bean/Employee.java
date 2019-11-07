package com.xuyan.crud.bean;

public class Employee {
    private Integer id;

    private String lastName;

    private String gender;

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