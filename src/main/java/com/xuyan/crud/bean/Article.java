package com.xuyan.crud.bean;

import java.util.Date;

public class Article {
    private Integer id;

    private Integer empid;

    private String title;

    private Integer lastreadcomment;

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getLastreadcomment() {
        return lastreadcomment;
    }

    public void setLastreadcomment(Integer lastreadcomment) {
        this.lastreadcomment = lastreadcomment;
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
}