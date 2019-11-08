package com.xuyan.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xuyan.crud.bean.Notice;
import com.xuyan.crud.bean.NoticeExample;
import com.xuyan.crud.bean.NoticeExample.Criteria;
import com.xuyan.crud.dao.NoticeMapper;

@Service
public class NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;
	
	public List<Notice> getAll(){
		NoticeExample example = new NoticeExample();
		Criteria criteria = example.createCriteria();
		example.setOrderByClause("publishtime DESC");
		return noticeMapper.selectByExampleWithBLOBs(example);
	}

	public void addNewNotice(Notice notice) {
		
		noticeMapper.insertSelective(notice);
		
	}

	public void updateNoticeById(Notice notice) {
		noticeMapper.updateByPrimaryKeySelective(notice);
		
	}

	public Notice getNoticeById(Integer id) {
		Notice notice = noticeMapper.selectByPrimaryKey(id);
		return notice;
	}

	public void deleteNoticeById(Integer id) {
		noticeMapper.deleteByPrimaryKey(id);
		
	}

	
}
