package com.xuyan.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xuyan.crud.bean.Article;
import com.xuyan.crud.bean.ArticleExample;
import com.xuyan.crud.dao.ArticleMapper;

@Service
public class ArticleService {
	
	@Autowired
	ArticleMapper articleMapper;

	public List<Article> getAll() {
		ArticleExample example = new ArticleExample();
		
		return articleMapper.selectByExampleWithBLOBs(example);
	}

	/**
	 * @param article
	 */
	public void addArticle(Article article) {
		articleMapper.insertSelective(article);
		
	}

	public void updateById(Article article) {
		articleMapper.updateByPrimaryKeyWithBLOBs(article);
	}

	public Article getArticleById(Integer id) {
		Article article = articleMapper.selectByPrimaryKey(id);
		return article;
	}

	public void deleteArticleById(Integer id) {
		articleMapper.deleteByPrimaryKey(id);
	}
	
	public List<Integer> getIdByEmpid(Integer id){
		return articleMapper.selectIdByEmpid(id);
	}
	
}
