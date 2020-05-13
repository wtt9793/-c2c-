<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>订单中心</title>
<link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon" />
<link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
<link rel="stylesheet" href="<%=basePath%>css/user.css" />

<!-- bootstrap -->
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>

<script type="text/javascript">

		function ordersDeliver(orderNum){
	
		location.href ='<%=basePath%>orders/deliver/'+orderNum
	
		alert("发货成功，请送货给对方，并等待确认收货~")
	}
		
		function ordersReceipt(orderNum,orderPrice,goodsId){
			location.href ='<%=basePath%>orders/receipt?orderNum='+orderNum+'&orderPrice='+orderPrice+'&goodsId='+goodsId;  
			
			alert("收货成功，感谢您的信任~")
		}

            function viewPersonal(id){
                $.ajax({
                    url:'<%=basePath%>admin/getUser',
                    type:'GET',
                    data:{id:id},
                    dataType:'json',
                    success:function(json){
                        if(json){
                            $('#myviewform').find("input[name='id']").val(json.id);
                            $('#myviewform').find("input[name='phone']").val(json.phone);
                            $('#myviewform').find("input[name='username']").val(json.username);
                            $('#myviewform').find("input[name='qq']").val(json.qq);
                            $('#myviewform').find("input[name='power']").val(json.power);
                            $('#myviewform').find("input[name='createAt']").val(json.createAt);
                            $('#viewModal').modal('toggle');
                        }
                    },
                    error:function(){
                        alert('请求超时或系统出错!!!!');
                        $('#viewModal').modal('hide');
                    }
                });
            }

        function show(id){
            var show1 = document.getElementById('t1'); //设置一个变量用于接收e799bee5baa6e58685e5aeb931333335303532id=t1的元素
            var show2= document.getElementById('t2'); //设置一个变量用于接收id=t2的元素
            var show3 = document.getElementById('test1').style.width='80%'
            if(show1.style.display != 'block'){ //判断如果id=t1的display不是block
                show1.style.display = 'block'; //将=t1的display样式赋值成block;其它不想显示变为none,否则相反
                show2.style.display='none';
            }else{
                show1.style.display = 'none';
                show2.style.display='block';
            }
        }

	

</script>

</head>
<body>
	<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="<%=basePath%>goods/homeGoods">
                <h1 class="logo"></h1>
            </a>
            <a href="<%=basePath%>goods/homeGoods">
                 <img src="<%=basePath%>img/home_header.png"  style="margin-left: 20px;" >
            </a>
            <a href="<%=basePath%>user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--

            描述：左侧个人中心栏
        -->
        <div id="user_nav">
            <div class="user_info">
                <div class="head_img">
                    <img src="<%=basePath%>img/photo.jpg">
                </div>
                <div class="big_headimg">
                    <img src="">
                </div>
                <span class="name">${cur_user.username}</span><hr>
              <!--   <span class="school">莆田学院</span> -->
                  <a class="btn" style="width: 98%;background-color: #99cc99;color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
               <span class="btn" data-toggle="modal" data-target="#myModal" style="width: 98%;background-color: rgb(79, 190, 246); color:rgba(255, 255, 255, 1);margin-top:0.5cm;">我的信用积分：${cur_user.power}</span>
                
            </div>
            <div class="home_nav">
                <ul>
                    <a href="<%=basePath%>orders/myOrders">
                        <li class="notice">
                            <div></div>
                            <span>订单中心</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allFocus">
                        <li class="fri">
                            <div></div>
                            <span>关注列表</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>goods/publishGoods">
                        <li class="store">
                            <div></div>
                            <span>发布物品</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allGoods">
                        <li class="second">
                            <div></div>
                            <span>我的闲置</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/basic">
                        <li class="set">
                            <div></div>
                            <span>个人设置</span>
                            <strong></strong>
                        </li>
                    </a>
                </ul>
            </div>
        </div>
			<!--

            描述：右侧内容区域
        -->

			<div id="user_content">
				<%--<div id="t1" style="display:none" class="recommend">--%>
					<%--<div class="title">--%>
						<%--<span class="text">可能认识的人</span>--%>
						<%--<span class ="change">--%>
                    <%--<input type="button" value="换一组" id="btn" class="btn btn-success btn-xs" style="width: 40px;height: 24px; padding-left: 0px;border-left-width: 1px;padding-right: 0px;" onclick="show(t2);"/>--%>
                    <%--</span>--%>
						<%--&lt;%&ndash;<span class="change">换一组</span>&ndash;%&gt;--%>
						<%--&lt;%&ndash;<span class="underline"></span>&ndash;%&gt;--%>
						<%--<div class="progress">--%>
							<%--<div class="progress-bar progress-bar-striped active" role="progressbar" id="test1" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">--%>
								<%--<span class="sr-only">45% Complete</span>--%>
							<%--</div>--%>
						<%--</div>--%>
					<%--</div>--%>
					<%--<ul>--%>
						<%--<li>--%>
							<%--&lt;%&ndash;<button type="button" class="head_img" onclick="viewPersonal(25)"></button>&ndash;%&gt;--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[5].id})">--%>
								<%--<img src="<%=basePath%>img/photo1.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[5].username}</span>--%>
							<%--&lt;%&ndash;点赞（未实现）&ndash;%&gt;--%>
							<%--&lt;%&ndash;<div class="glyphicon glyphicon-thumbs-up btn-lg"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[6].id})">--%>
								<%--<img src="<%=basePath%>img/photo2.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[6].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[7].id})">--%>
								<%--<img src="<%=basePath%>img/photo3.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[7].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[8].id})">--%>
								<%--<img src="<%=basePath%>img/photo4.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[8].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[9].id})">--%>
								<%--<img src="<%=basePath%>img/photo5.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[9].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
					<%--</ul>--%>
				<%--</div>--%>
				<%--&lt;%&ndash;描述：最右侧，可能认识的人&ndash;%&gt;--%>

				<%--<div id="t2" style="display:block" class="recommend">--%>

					<%--<div class="title">--%>


						<%--<span class="text">可能认识的人</span>--%>

						<%--<span class ="change">--%>
                    <%--<input type="button" value="换一组" id="btn1" class="btn btn-success btn-xs" style="width: 40px;height: 24px; padding-left: 0px;border-left-width: 1px;padding-right: 0px;" onclick="show(t1);"/>--%>
                    <%--</span>--%>
						<%--&lt;%&ndash;<span class="change">换一组</span>&ndash;%&gt;--%>
						<%--<div class="progress">--%>
							<%--<div class="progress-bar progress-bar-striped active" id="test" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">--%>
								<%--<span class="sr-only">45% Complete</span>--%>
							<%--</div>--%>
						<%--</div>--%>
					<%--</div>--%>

					<%--<ul>--%>

						<%--<li>--%>
							<%--&lt;%&ndash;<button type="button" class="head_img" onclick="viewPersonal(25)"></button>&ndash;%&gt;--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[0].id})">--%>
								<%--<img src="<%=basePath%>img/photo1.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[0].username}</span>--%>
							<%--&lt;%&ndash;点赞（未实现）&ndash;%&gt;--%>
							<%--&lt;%&ndash;<div class="glyphicon glyphicon-thumbs-up btn-lg"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[1].id})">--%>
								<%--<img src="<%=basePath%>img/photo2.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[1].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[2].id})">--%>
								<%--<img src="<%=basePath%>img/photo3.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[2].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[3].id})">--%>
								<%--<img src="<%=basePath%>img/photo4.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[3].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<a href="#" class="head_img" role="button" onclick="viewPersonal(${users[4].id})">--%>
								<%--<img src="<%=basePath%>img/photo5.jpg">--%>
							<%--</a>--%>
							<%--<span>${users[4].username}</span>--%>
							<%--&lt;%&ndash;<div class="fa fa-plus-square"></div>&ndash;%&gt;--%>
						<%--</li>--%>
					<%--</ul>--%>
				<%--</div>--%>

				<div class="share">

					<!--

                    描述：订单展示
                -->
					<h1 style="text-align: center">订单中心</h1>
					<hr />
					<div class="share_content">
						  <c:if test="${empty orders and empty ordersOfSell}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
					 <c:if test="${!empty orders or !empty ordersOfSell}">

						<div class="story">

							<div class="container">
								<!-- Nav tabs -->
								<ul class="nav nav-tabs" role="tablist" style="width: 46%">
									<!-- <li class="nav-item"><a class="nav-link active"
										data-toggle="tab" href="#home">全部订单</a></li> -->
									<li class="nav-item"><a class="nav-link active" data-toggle="tab"
										href="#orders_my" >我买的</a></li>
									<li class="nav-item" ><a class="nav-link" data-toggle="tab"
										href="#orders_other" >我卖的</a></li>
								</ul>

								<!-- Tab panes -->
								<div class="tab-content" style="width: 46%">
									<!-- <div id="home" class="container tab-pane active"
										style="width: 100%">
										<br>
										<from>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit, sed do eiusmod tempor incididunt ut labore et dolore
											magna aliqua.</p>
										</from>
									</div> -->
									<!-- 买家订单中心 -->
									<div id="orders_my" class="container tab-pane active"
										style="width: 100%">
										<br>
										<form class="form-horizontal" role="form">
											<div class="table-responsive">
												<table class="table">
													<thead>
													<tr>
													</tr>
														<tr>
														  <th >订单编号</th>
															<th>名称</th>
															<th>价格</th>
															<th>备注</th>
															<%--<th>图片</th>--%>
															<th>操作</th>

														</tr>
													</thead>
													<tbody>
													<c:forEach var="items" items="${orders}">
                                            	<tr>
															<td>${items.orderNum}</td>
															<td>${items.goods.name}</td>
															<td>${items.goods.price}</td>
															<td>${items.orderInformation}</td>
													<%--<td>${goodsAndImage[0].images[0].imgUrl}</td>--%>
															<%--<c:forEach var="items1" items="${goodsAndImage}">--%>
													        <%--<td><img src="../upload/${items1[0].images[0].imgUrl }" style="width: 50px"></td>--%>
															<%--</c:forEach>--%>
															<td>
															<c:if test="${items.orderState==1}"><input type="button" value="待发货" class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==2}"><input type="button" value="收&nbsp&nbsp&nbsp&nbsp货" onclick="ordersReceipt(${items.orderNum},${items.orderPrice},${items.goods.id})" class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==3}"><input type="button" value="已完成" class="btn btn-info"/></c:if>
															</td>
														</tr>
                    					</c:forEach> 	
													</tbody>
												</table>
											</div>

										</form>
									</div>
									<!-- 卖家订单中心 -->
									<div id="orders_other" class="container tab-pane fade"
										style="width: 100%">
										<br>
										<form class="form-horizontal" role="form">
											<div class="table-responsive">
												<table class="table">
													<thead>
													<tr>
													</tr>
														<tr class="text-center">
														  <th>订单编号</th>
															<th>名称</th>
															<th>价格</th>
															<th>备注</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody>
													<c:forEach var="items" items="${ordersOfSell}">
                                            		<tr>
															<td>${items.orderNum}</td>
															<td>
															${items.goods.name}
															</td>
															<td>${items.goods.price}</td>
															<td>${items.orderInformation}</td>
															<td>
															
															<c:if test="${items.orderState==1}"><input type="button" value="发&nbsp&nbsp&nbsp&nbsp货" onclick="ordersDeliver(${items.orderNum})" class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==2}"><input type="button" value="待收货"  class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==3}"><input type="button" value="已完成" class="btn btn-info"/></c:if>
															
															
															</td>
													</tr>
                    					</c:forEach>
												 </tbody>
												</table>
											</div>

										</form>
									</div>
								</div>
							</div>
						</div>

						     </c:if>

					</div>
				</div>
				<!--

                描述：最右侧，可能认识的人
            
				<div class="recommend">
					<div class="title">
						<span class="text">可能认识的人</span> <span class="change">换一组</span> <span
							class="underline"></span>
					</div>
					<ul>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo1.jpg">
						</a> <span>Brudce</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo2.jpg">
						</a> <span>Graham</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo3.jpg">
						</a> <span>hly</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo4.jpg">
						</a> <span>Danger-XFH</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo5.jpg">
						</a> <span>Keithw</span>
							<div class="fa fa-plus-square"></div></li>
					</ul>
				</div>
				-->


			</div>
		</div>
	</div>
	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title middle" id="myModalLabel">查看用户信息</h4>
				</div>
				<div class="modal-body" style="height: 220px;">
					<form id="myviewform">
						<div class="form-group">
							<label for="recipient-name" class="control-label col-sm-2" >名称:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="message-text" name="username" readonly/>
							</div>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label col-sm-2">手机号:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="message-text" name="phone" readonly/>
							</div>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label col-sm-2">qq号:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="message-text" name="qq" readonly/>
							</div>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label col-sm-2">信用积分:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="message-text" name="power" readonly/>
							</div>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label col-sm-2">开户时间:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="message-text" name="createAt" readonly/>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>

</body>
</html>