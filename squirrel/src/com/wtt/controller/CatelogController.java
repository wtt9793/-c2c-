package com.wtt.controller;

import org.springframework.stereotype.Controller;

import com.wtt.service.CatelogService;

import javax.annotation.Resource;

/**
 * Created by wtt on 2020/2/9.
 */
@Controller
public class CatelogController {
    @Resource
    private CatelogService catelogService;

}
