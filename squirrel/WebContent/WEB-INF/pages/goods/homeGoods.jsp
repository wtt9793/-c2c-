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
    <meta charset="utf-8" />
    <title>【上应大】校园二手交易平台</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <link rel="stylesheet" href="<%=basePath%>css/test.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <%--<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">--%>
    <script type="text/javascript" src="<%=basePath%>js/test.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />

    <script>
        var show_num = [];
        // var num = show_num.join("");

        function showLogin() {
            if($("#signup-show").css("display")=='block'){
                $("#signup-show").css("display","none");
            }
            if($("#login-show").css("display")=='none'){
                $("#login-show").css("display","block");
            }else{
                $("#login-show").css("display","none");
            }
        }
        function showSignup() {
            if($("#login-show").css("display")=='block'){
                $("#login-show").css("display","none");
            }
            if($("#signup-show").css("display")=='none'){
                $("#signup-show").css("display","block");
            }else{
                $("#signup-show").css("display","none");
            }
        }
        function ChangeName() {
            if($("#changeName").css("display")=='none'){
                $("#changeName").css("display","block");
            }else{
                $("#changeName").css("display","none");
            }
        }
        
        $(document).ready(function() {

            //异步验证
            $("#phone").blur(function () {
                var phone = $(this).val();
                $.ajax({
                    url: '<%=basePath%>user/register',
                    type: 'POST',
                    data: {phone: phone},
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $("#errorPhone").html("账号已被注册，请重新输入!");
                            $("#register").attr("disabled", true);
                        } else {
                            $("#errorPhone").empty();
                            $("#register").attr("disabled", false);
                        }
                    },
                    error: function () {
                        alert('请求超时或系统出错!');
                    }
                });


            });
            $(function () {

                draw(show_num);
                $("#canvas").on('click', function () {
                    draw(show_num);
                })
            });

            $("#loginIn").on('click',function () {
                var code = $(".input-val").val().toLowerCase();
                var num = show_num.join("");
                var phone = $("#login_phone").val();
                var password = $("#login_password").val();

                        if(code==''){
                            alert('请输入验证码！');
                        }else if(code == num){
                            $("#errorCode").empty();
                            alert('提交成功！');
                            // $(".input-val").val('');
                            // draw(show_num);
                        }else{
                            $("#errorCode").html("您输入验证码有误!");
                            $(".input-val").val('');
                            // draw(show_num);
                        }



                $.ajax({
                    url: '<%=basePath%>user/login',
                    type: 'POST',
                    data: {code: code, num: num,phone: phone, password: password},
                    dataType: 'json',
                    success: function (json) {
                    },
                })
            })

            $("#login_password").blur(function () {
            // $(".input-val").blur(function () {

                    var phone = $("#login_phone").val();
                    var password = $("#login_password").val();
                     // var code = $("#code").val().toLowerCase();
                    // var code = $(".input-val").val().toLowerCase();
                    //  var num = show_num.join("");
                    $.ajax({
                        url: '<%=basePath%>user/password',
                        type: 'POST',
                        data: {phone: phone, password: password},
                        dataType: 'json',
                        success: function (json) {
                            // if (json) {

                            if (json.flag) {
                                $("#errorPassword").html("您输入的账号或密码有误!");
                                // alert('您输入的账号或密码有误!');
                                // $("#login_password").val('');
                                $("#loginIn").attr("disabled", true);

                            }
                            else{
                                $("#errorPassword").empty();
                                $("#loginIn").attr("disabled", false);
                            }

                            // if (json.flag == false) {
                            //
                            //     $("#login_errorPhone").html("您输入账号有误!");
                            //
                            //     $("#login_phone").val('');
                            //
                            //
                            // }
                            // else{
                            //     $("#login_errorPhone").empty();
                            //
                            //     $("#loginIn").attr("disabled", false);
                            // }


                                // } else {
                                //     if (json.flag) {
                                //         $("#errorPassword").html("请核对账号密码，再重新输入!");
                                //         $("#loginIn").attr("disabled", true);
                                //     } else {
                                //         $("#errorPassword").empty();
                                //         $("#loginIn").attr("disabled", false);
                                //     }
                                // }
                            },
                        // },
                        error: function (json) {
                            // alert("1234")
                        }
                    });

                });

            });

            function showaside() {
                var aside = document.getElementById("test");
                if (aside.style.transform == "translate(0px, 0px)") {
                    aside.style.transform = "translate(100%,10px)";
                }
                else {
                    aside.style.transform = "translate(0,0)";
                }
            }







    </script>
<body ng-view="ng-view">
<!--
    描述：顶部
-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="white nav1">
        <div class="nav-wrapper">
            <img src="<%=basePath%>img/xiaohui.jpg" style="height: 64px;width: 64px;">
            <a href="<%=basePath%>goods/homeGoods" class="logo" style="position: absolute;margin-left: 0px;">
                <em class="em1">上应大</em>
                <em class="em2">校园二手平台</em>
                <em class="em3"></em>
            </a>
            <div style="width: 380px;position: absolute;top: 0px;right: 500px;left: 340px;">
            <%--<div class="nav-wrapper search-bar">--%>
                <form class="ng-pristine ng-invalid ng-invalid-required" action="<%=basePath%>goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="点击搜索想要的东西哦" style="height: 40px;"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                      	<input type="submit" class="btn"value="搜索"></input>
                        <label for="search" class="active">
                            <i ng-click="search()" class="iconfont" style="color:lightskyblue;"></i>
                        </label>
                    </div>
                </form>
            </div>

            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                       <%--<button onclick="showLogin()" data-toggle="tooltip" --%>
                                <%--title="您需要先登录哦！" class="red lighten-1 waves-effect waves-light btn" 	>--%>
                            <%--我要发布</button>--%>
                               <a role="button" onclick="showLogin()" data-toggle="tooltip"
                               title="您需要先登录哦！">
                               我要发布</a>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="publish-btn">
                        <%--<button data-position="bottom" class="red lighten-1 waves-effect waves-light btn">--%>
                            <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                        <%--</button>--%>
                    </li>
                    <li>
                        <a href="<%=basePath%>user/allGoods">我发布的商品</a>
                    </li>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
                    <!-- <li class="notification">
                        <i ng-click="showNotificationBox()" class="iconfont"></i>
                    </li> -->
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="<%=basePath%>user/home">个人中心</a></li>
                                <li><a href="<%=basePath%>user/allFocus">我的关注</a></li>
                                <li><a onclick="ChangeName()">更改用户名</a></li>
                                <li><a href="<%=basePath%>admin" target="_blank">登录后台</a></li>
                                <li><a href="<%=basePath%>user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
                <c:if test="${empty cur_user}">
                    <li>
                        <a onclick="showLogin()">登录</a>
                    </li>
                    <li>
                        <a onclick="showSignup()">注册</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</div>
<!--
    描述：登录
-->
<div ng-controller="loginController" class="ng-scope">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showLogin()">
                    <div class="col s12 title"></div>
                </a>
                <%--<form action="<%=basePath%>user/login" method="post" role="form">--%>
                <form method="post" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="login_phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;<div id="login_errorPhone" style="color:red;display:inline;"></div></label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" id="login_password"  name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码&nbsp;&nbsp;<div id="errorPassword" style="color:red;display:inline;"></div></label>
                      <!--   <a ng-click="showForget()" class="forget-btn">忘记密码？</a> -->
                    </div>
                    <div class="code">
                        <input type="text" id="code" name="code" value="" placeholder="请输入验证码（不区分大小写）" required="required" class="input-val">
                        <div id="errorCode" style="color:red;display:inline;" hidden></div>
                        <canvas id="canvas" width="100" height="30" style="border-right-width: 0px;"></canvas>
                        <%--<input type="text" id="num" name="canvas"/>--%>


                    </div>
                    <button type="submit" id="loginIn" class="waves-effect waves-light btn login-btn red lighten-1">
                        <i class="iconfont left"></i>
                        <em>登录</em>
                    </button>
                    <div class="col s12 signup-area">
                        <em>没有账号？赶快</em>
                        <a onclick="showSignup()" class="signup-btn">注册</a>
                        <em>吧！</em>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--

    描述：注册
-->
<div ng-controller="signupController" class="ng-scope">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showSignup()">
                    <div class="col s12 title"></div>
                </a>
                <form action="<%=basePath%>user/addUser" method="POST" role="form" id="signup_form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;<div id="errorPhone" style="color:red;display:inline;"></div></label>
                           
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label>
                    </div>

                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="submit" id="register" class="waves-effect waves-light btn verify-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--更改用户名-->
<div ng-controller="changeNameController" class="ng-scope">
    <div id="changeName" class="change-name stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <div class="col s12 title">
                    <h1>修改用户名</h1>
                </div>
                <form action="<%=basePath%>user/changeName" method="post"  role="form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>修改用户名</label>
                         
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                   <button class="waves-effect waves-light btn publish-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>确认</em>
                        </button>   
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--
    描述：左侧导航条
-->
<div ng-controller="sidebarController" class="sidebar stark-components ng-scope" style="top: 80px;height: 700px;">
    <ul ng-class="{true: 'active'}[isAll]">
        <a href="<%=basePath%>goods/catelog" class="index">
            <img src="<%=basePath%>img/new.png">
            <em>最新发布</em>
        </a>
    </ul>

    <ul ng-class="{true: 'active'}[isRide]">
        <a href="<%=basePath%>goods/catelog/2" class="ride">
            <img src="<%=basePath%>img/zihangche.png"/>
            <em>校园代步</em>
        </a>
    </ul>
    <ul ng-class="{true: 'active'}[isCommodity]">
        <a href="<%=basePath%>goods/catelog/3" class="commodity">
            <img src="<%=basePath%>img/dianqi.png"/>
            <em>电器日用</em>
        </a>
    </ul>
    <ul ng-class="{true: 'active'}[isBook]">
        <a href="<%=basePath%>goods/catelog/4" class="book">
            <img src="<%=basePath%>img/shuben.png"/>
            <em>图书教材</em>
        </a>
    </ul>

    <ul ng-class="{true: 'active'}[isDigital]">
        <a href="<%=basePath%>goods/catelog/1" class="digital">
            <img src="<%=basePath%>img/shuma.png"  />
            <em>闲置数码</em>
        </a>
    </ul>


    <ul ng-class="{true: 'active'}[isSport]">
        <a href="<%=basePath%>goods/catelog/6" class="sport">
            <img src="<%=basePath%>img/yundonglei.png"/>
            <em>运动棋牌</em>
        </a>
    </ul>
    <ul ng-class="{true: 'active'}[isSmallthing]">
        <a href="<%=basePath%>goods/catelog/7" class="smallthing">
            <img src="<%=basePath%>img/xiangbao.png"/>
            <em>衣物箱包</em>
        </a>
    </ul>
    <ul ng-class="{true: 'active'}[isMakeup]">
        <a href="<%=basePath%>goods/catelog/5" class="makeup">
            <img src="<%=basePath%>img/meizhuang.png"/>
            <em>美妆饰品</em>
        </a>
    </ul>
    <br>
    <br>
    <button class="btn btn-primary" onclick="showaside()">点击联系我哦~</button>
    <br>





</div>
<!--

    描述：右侧显示部分
-->
<div class="main-content">
    <%--<a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">--%>
        <%--Link with href--%>
    <%--</a>--%>

        <%--<div class="collapse" id="collapseExample">--%>

            <aside id="test" style="width:200px;position: absolute;transform: translate(100%,10px);transition: all 2s">
                <a href="https://wtt9793.github.io" target="_blank">关于我们</a><em>-</em>
                <a href="https://wtt9793.github.io" target="_blank">联系我们</a>
                <br>
                <hr>
                <a href="<%=basePath%>admin" target="_blank">登录后台</a>
                <p>©2020 上应大校园二手平台</p>
            </aside>
        <%--</div>--%>
            <%--<aside id="test1" style="width:200px;position: absolute;transform: translate(100%,10px);transition: all 2s">--%>
                <%----%>
            <%--</aside>--%>

    <%--<div ng-controller="sidebarController" class="sidebar stark-components ng-scope" style="top: 80px">--%>
    <%--<div class="info">--%>
        <%----%>
    <%--</div>--%>
    <%--</div>--%>
    <!--

        描述：右侧banner（图片）部分
    -->
    <div class="slider-wapper">
        <div class="slider" style="height: 440px; touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
            <ul class="slides" style="height: 400px;">
                <li class="active" style="opacity: 1;">
                    <a href="<%=basePath%>goods/homeGoods">
                        <div class="bannerimg">
                            <ul class="bannerul">
                                <p class="text1">Hello：</p>
                                <p class="text2">欢迎来到【上应大】校园二手平台。临近毕业季的</p>
                                <p class="text3">你，是否有太多的闲置与校友分享，为了追求更好的校园服</p>
                                <p class="text4">务，我们打造了一个全新的校园平台——<span>上应大二手平台</p>
                                <p class="text5">这里有更多的闲置分享，更自由的校园话题讨论，你想要的，都在这里。</p>
                                <p class="text6">加入上应大校园二手平台，你的大学，应更精彩。</p>
                            </ul>
                          <!--   <div class="logoimg">
                                <img src="../img/p_logo.jpg" />
                            </div> -->
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!--

        描述：最新发布
    -->
    <div class="index-title">
        <a href="">最新发布</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：闲置数码
    -->
    <div class="index-title">
        <a href="">闲置数码</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：校园代步
    -->
    <div class="index-title">
        <a href="">校园代步</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods2}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">电器日用</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods3}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">图书教材</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods4}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">美妆饰品</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods5}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">运动棋牌</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods6}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">衣物箱包</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods7}">//
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>上应大</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>