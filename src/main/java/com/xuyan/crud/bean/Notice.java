package com.xuyan.crud.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Notice {
    private Integer id;

    private Integer empid;

    private Integer todeptid;

    private String title;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date publishtime;

    private String content;

    
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public Integer getTodeptid() {
        return todeptid;
    }

    public void setTodeptid(Integer todeptid) {
        this.todeptid = todeptid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Date getPublishtime() {
        return publishtime;
    }

    public void setPublishtime(Date publishtime) {
        this.publishtime = publishtime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

	@Override
	public String toString() {
		return "Notice [id=" + id + ", empid=" + empid + ", todeptid=" + todeptid + ", title=" + title
				+ ", publishtime=" + publishtime + ", content=" + content + "]";
	}
    
    
}