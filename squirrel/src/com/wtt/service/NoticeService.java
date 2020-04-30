package com.wtt.service;

import java.util.List;

import com.wtt.pojo.Notice;
import com.wtt.pojo.NoticeExtend;

public interface NoticeService {

	List<Notice> getNoticeList();
	
	public void insertSelective(Notice notice);
	
	



}
