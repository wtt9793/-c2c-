<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人设置</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
     <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript">
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
              <!--   <span class="school">东华大学</span> -->
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
            <div class="basic">
                <form:form action="../user/updateInfo" method="post" commandName="user" role="form">
                    <h1>完善与修改个人信息</h1><hr />
                    <div class="changeinfo">
                        <span>昵称：</span>
                        <input class="in_info" type="text" name="username" placeholder="请输入昵称" value="${cur_user.username}"/>
                    </div><hr />
                    <div class="changeinfo">
                        <span>开通时间：</span>
                        <input class="in_info" type="text" name="createAt" value="${cur_user.createAt}" readonly="true"/>
                    </div><hr />
                    <div class="changeinfo">
                        <span>手机号码：</span>
                        <input class="in_info" type="text" name="phone" value="${cur_user.phone}" readonly="true"/>
                        <span id="checkphone">已验证</span>
                    </div><hr />
                    <div class="changeinfo">
                        <span>QQ：</span>
                        <input class="in_info" type="text" name="qq" placeholder="请输入QQ" value="${cur_user.qq}"/>
                    </div>
                    <input type="submit" class="setting-save" value="保存修改信息" />
                </form:form>
            </div>
            <div id="t1" style="display:none" class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class ="change">
                    <input type="button" value="换一组" id="btn" class="btn btn-success btn-xs" style="width: 40px;height: 24px; padding-left: 0px;border-left-width: 1px;padding-right: 0px;" onclick="show(t2);"/>
                    </span>
                    <%--<span class="change">换一组</span>--%>
                    <span class="underline"></span>
                </div>
                <ul>
                    <li>
                        <%--<button type="button" class="head_img" onclick="viewPersonal(25)"></button>--%>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(7)">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>user4</span>
                        <%--点赞（未实现）--%>
                        <%--<div class="glyphicon glyphicon-thumbs-up btn-lg"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(8)">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>user5</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(9)">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>user6</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(10)">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>user7</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(3)">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>靓仔</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                </ul>
            </div>
                <%--描述：最右侧，可能认识的人--%>
           <div id="t2" style="display:block" class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class ="change">
                    <input type="button" value="换一组" id="btn1" class="btn btn-success btn-xs" style="width: 40px;height: 24px; padding-left: 0px;border-left-width: 1px;padding-right: 0px;" onclick="show(t1);"/>
                    </span>
                    <%--<span class="change">换一组</span>--%>
                    <span class="underline"></span>
                </div>
                <ul>
                    <li>
                        <%--<button type="button" class="head_img" onclick="viewPersonal(25)"></button>--%>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(25)">
                        <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>SC</span>
                            <%--点赞（未实现）--%>
                        <%--<div class="glyphicon glyphicon-thumbs-up btn-lg"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(26)">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>SX</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(23)">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>小丽</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(4)">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>user1</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(5)">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>user2</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                </ul>
            </div>

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