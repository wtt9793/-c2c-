package com.wtt.service;

import java.util.List;

import com.wtt.pojo.Catelog;

/**
 * Created by wtt on 2020/2/9.
 */
public interface CatelogService {
    public List<Catelog> getAllCatelog();
    public int getCount(Catelog catelog);
    Catelog selectByPrimaryKey(Integer id);
    int updateByPrimaryKey(Catelog record);
    int updateCatelogNum(Integer id,Integer number);
}
