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
import com.xuyan.crud.bean.Article;
import com.xuyan.crud.bean.Comment;
import com.xuyan.crud.bean.Msg;
import com.xuyan.crud.service.ArticleService;
import com.xuyan.crud.service.CommentService;

@Controller
@RequestMapping("/article")
public class ArticleController {
	
	@Autowired
	ArticleService articleService;
	@Autowired
	CommentService commentService;
	
	// 获取全部文章和评论
	@RequestMapping(value = "/articles", method = RequestMethod.GET)
	public String getAllArticle(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Map<String, Object> map, 
			HttpSession session) {
		PageHelper.startPage(pn, 5);
		List<Article> articles = articleService.getAll();
		PageInfo page = new PageInfo(articles, 5);
		map.put("pageInfo", page);
		List<Comment> all = commentService.getAll();
		map.put("allComment", all);
		if(session.getAttribute("usertype").equals("manager")) {
			return "manager_forum";
		}else {
			return "emp_forum";
		}
		
	}
	
	// 提交新文章
	@ResponseBody
	@RequestMapping(value = "/article", method = RequestMethod.POST)
	public Msg addArticle(Article article) {
		Msg msg = new Msg();
		article.setPublishtime(new Date());
		articleService.addArticle(article);
		
		return msg.success();
	}
	
	// 获取文章内容
	@ResponseBody
	@RequestMapping(value = "/article/{id}", method = RequestMethod.GET)
	public Msg getArticleById(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		Article article = articleService.getArticleById(id);
		
		return msg.success().add("article", article);
	}
	
	// 更新文章信息
	@ResponseBody
	@RequestMapping(value = "/article/{id}", method = RequestMethod.PUT)
	public Msg updateArticle(@PathVariable("id") Integer id, Article article) {
		Msg msg = new Msg();
		article.setId(id);
		articleService.updateById(article);
		
		return msg.success();
	}
	
	// 删除文章
	@ResponseBody
	@RequestMapping(value = "/article/{id}", method = RequestMethod.DELETE)
	public Msg deleteArticle(@PathVariable("id") Integer id) {
		Msg msg = new Msg();
		articleService.deleteArticleById(id);
		
		return msg.success();
	}
	
}
