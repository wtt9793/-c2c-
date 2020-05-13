package com.wtt.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.wtt.pojo.*;
import com.wtt.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/orders")
public class OrdersController {
	
	@Resource
	private OrdersService ordersService;
	@Resource
	private GoodsService goodsService;
	@Resource
	private PurseService  purseService;

	@Resource
    private UserService userService;
    @Resource
    private ImageService imageService;
	
    
    ModelAndView mv = new ModelAndView();
	
	 /**
     * 我的订单 买
     */
    @RequestMapping(value = "/myOrders")
    public ModelAndView orders(HttpServletRequest request) {
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();
        int size = 10;
        List<Orders> ordersList1=new ArrayList<Orders>();
        List<Orders> ordersList2=new ArrayList<Orders>();
        List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
        List<User> users=userService.getUserOrderByDate(size);
        ordersList1 = ordersService.getOrdersByUserId(user_id);
        ordersList2 = ordersService.getOrdersByUserAndGoods(user_id);
        Purse myPurse=purseService.getPurseByUserId(user_id);
        for (int i = 0; i < ordersList1.size(); i++) {
            // 将用户信息和image信息封装到GoodsExtend类中，传给前台
            GoodsExtend goodsExtend = new GoodsExtend();
            Orders goods = ordersList1.get(i);
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());

            goodsExtend.setImages(images);
            goodsAndImage.add(i, goodsExtend);
        }
        mv.addObject("ordersOfSell",ordersList2);
        mv.addObject("orders",ordersList1);
        mv.addObject("myPurse",myPurse);
        mv.addObject("users",users);
        mv.addObject("goodsAndImage",goodsAndImage);
        mv.setViewName("/user/orders");
        return mv;
    }
    
    
	 /**
     * 提交订单
     */
    @RequestMapping(value = "/addOrders")
    public String addorders(HttpServletRequest request,Orders orders) {
    	Date d=new Date();//获取时间
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//转换格式
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();
        orders.setUserId(user_id);
        orders.setOrderDate(sdf.format(d));
        Goods goods=new Goods();
        goods.setStatus(0);
        goods.setId(orders.getGoodsId());
        goodsService.updateGoodsByGoodsId(goods);
        ordersService.addOrders(orders);
        Float balance=orders.getOrderPrice();
        purseService.updatePurseOfdel(user_id,balance);
        return "redirect:/orders/myOrders";
    }
    
    /**
     * 发货 根据订单号
     */
    @RequestMapping(value = "/deliver/{orderNum}")
    public String deliver(HttpServletRequest request,@PathVariable("orderNum")Integer orderNum) {
      
    	ordersService.deliverByOrderNum(orderNum);
        
        
        return "redirect:/orders/myOrders";
    }
    
    
    
    /**
     * 收货
     */
    @RequestMapping(value = "/receipt")
    public String receipt(HttpServletRequest request) {
    Integer orderNum=Integer.parseInt(request.getParameter("orderNum"));
    	Float balance=Float.parseFloat(request.getParameter("orderPrice"));
    	Integer goodsId=Integer.parseInt(request.getParameter("goodsId"));
    	Integer userId=goodsService.getGoodsById(goodsId).getUserId();
    	ordersService.receiptByOrderNum(orderNum);
    	purseService.updatePurseByuserId(userId,balance);
    	/*买家确认收货后，卖家钱包+*/
        return "redirect:/orders/myOrders";
    }

}
