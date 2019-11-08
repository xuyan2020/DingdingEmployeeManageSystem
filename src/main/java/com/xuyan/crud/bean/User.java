package com.xuyan.crud.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class User {
    private Integer empid;

    private String username;

    private String password;

    private String usertype;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date regtime;

    private String question;

    private String answer;

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype == null ? null : usertype.trim();
    }

    public Date getRegtime() {
        return regtime;
    }

    public void setRegtime(Date regtime) {
        this.regtime = regtime;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question == null ? null : question.trim();
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer == null ? null : answer.trim();
    }

	@Override
	public String toString() {
		return "User [empid=" + empid + ", username=" + username + ", password=" + password + ", usertype=" + usertype
				+ ", regtime=" + regtime + ", question=" + question + ", answer=" + answer + "]";
	}
    
}