package com.xuyan.crud.controller;

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
import com.xuyan.crud.bean.Article;
import com.xuyan.crud.bean.Comment;
import com.xuyan.crud.bean.Msg;
import com.xuyan.crud.service.ArticleService;
import com.xuyan.crud.service.CommentService;

@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	CommentService commentService;
	@Autowired
	ArticleService articleService;
	
	// 根据empID获取全部通知
	@RequestMapping("/getAllByEmpid")
	public String getAllByEmpId(@RequestParam(value = "pn", defaultValue = "1") Integer pn, 
			Map<String, Object> map, 
			HttpSession session) {
		Integer id = (Integer) session.getAttribute("id");

		List<Integer> idByEmpid = articleService.getIdByEmpid(id);
		
		PageHelper.startPage(pn, 5);
		List<Comment> comments = commentService.getAllByArticleid(idByEmpid);
		PageInfo page = new PageInfo(comments, 5);
		map.put("pageInfo", page);
		
		return "manager_reply";
	}
	
	
	// 根据ID删除通知
	@ResponseBody
	@RequestMapping(value = "/comment/{id}", method = RequestMethod.DELETE)
	public Msg deleteCommentById(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		commentService.deleteCommentById(id);
		
		return msg.success();
	}
}
