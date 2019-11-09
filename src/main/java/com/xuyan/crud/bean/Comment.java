package com.xuyan.crud.bean;

import java.util.Date;

public class Comment {
    private Integer id;

    private Integer articleid;

    private Integer empid;

    private String content;

    private Date publishtime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getArticleid() {
        return articleid;
    }

    public void setArticleid(Integer articleid) {
        this.articleid = articleid;
    }

    public Integer getEmpid() {
        return empid;
    }

    public void setEmpid(Integer empid) {
        this.empid = empid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Date getPublishtime() {
        return publishtime;
    }

    public void setPublishtime(Date publishtime) {
        this.publishtime = publishtime;
    }

	@Override
	public String toString() {
		return "Comment [id=" + id + ", articleid=" + articleid + ", empid=" + empid + ", content=" + content
				+ ", publishtime=" + publishtime + "]";
	}
    
}