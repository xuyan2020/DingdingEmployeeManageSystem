package com.xuyan.crud.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xuyan.crud.bean.Comment;
import com.xuyan.crud.bean.CommentExample;
import com.xuyan.crud.bean.CommentExample.Criteria;
import com.xuyan.crud.dao.CommentMapper;

@Service
public class CommentService {
	
	@Autowired
	CommentMapper commentMapper;
	
	public List<Comment> getAll(){
		return commentMapper.selectByExample(null);
	}

	public void deleteCommentById(Integer id) {
		commentMapper.deleteByPrimaryKey(id);
		
	}

	public List<Comment> getAllByArticleid(List<Integer> ids) {
		List<Comment> list = new ArrayList<>();
		
		for (Integer id : ids) {
			CommentExample example = new CommentExample();
			Criteria criteria = example.createCriteria();
			criteria.andArticleidEqualTo(id);
			List<Comment> selectByExample = commentMapper.selectByExample(example);
			for (Comment comment : selectByExample) {
				list.add(comment);
				
			}
		}
		
		return list;
	}

	public void addNewComment(Comment comment) {
		commentMapper.insertSelective(comment);
		
	}


}
