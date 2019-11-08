package com.xuyan.crud.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuyan.crud.bean.Msg;
import com.xuyan.crud.bean.Notice;
import com.xuyan.crud.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// 获取全部通知
	@RequestMapping(value = "/notices", method = RequestMethod.GET)
	public String getAllNotice(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Map<String, Object> map) {
		PageHelper.startPage(pn, 5);
		List<Notice> all = noticeService.getAll();
		
		PageInfo pageInfo = new PageInfo(all, 5);
		map.put("pageInfo", pageInfo);
		return "manager_notice";
	}
	
	// 获取单条通知
	@ResponseBody
	@RequestMapping(value = "/notice/{id}", method = RequestMethod.GET)
	public Msg getNotice(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		Notice notice = noticeService.getNoticeById(id);
		return msg.success().add("notice", notice);
	}
	
	// 提交新通知
	@ResponseBody
	@RequestMapping(value = "/notice", method = RequestMethod.POST)
	public Msg addNewNotice(Notice notice, HttpSession session) {
		Msg msg = new Msg();
		Integer id = (Integer) session.getAttribute("id");
		notice.setEmpid(id);
		notice.setPublishtime(new Date());
		System.out.println(notice);
		noticeService.addNewNotice(notice);
		
		return msg.success();
	}
	
	// 修改通知操作
	@ResponseBody
	@RequestMapping(value = "/notice/{id}", method = RequestMethod.PUT)
	public Msg updateNoticeById(@PathVariable("id") Integer id, Notice notice) {
		Msg msg = new Msg();
		notice.setId(id);
		noticeService.updateNoticeById(notice);
		
		return msg.success();
	}
	
	// 删除通知操作
	@ResponseBody
	@RequestMapping(value = "/notice/{id}", method = RequestMethod.DELETE)
	public Msg deleteNotice(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		noticeService.deleteNoticeById(id);
		
		return msg.success();
	}
	
	
}
