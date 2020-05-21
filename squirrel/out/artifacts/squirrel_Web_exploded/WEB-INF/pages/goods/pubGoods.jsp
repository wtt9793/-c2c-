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
    <title>发布商品</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
   <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <!-- 图片上传即使预览插件 -->
    <link rel="stylesheet" href="<%=basePath%>css/fileinput.min.css">
    <script type="text/javascript" src="<%=basePath%>js/fileinput.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/zh.js"></script>

    <style>
        .container{padding-top:10px}
    </style>
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
            <a href="<%=basePath%>user/home">
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

	            描述：发布物品
        -->
        <div id="user_content">
            <div class="basic">
                <form:form action="../goods/publishGoodsSubmit" method="post" role="form" enctype="multipart/form-data">
                    <h1 style="margin-left: 210px;">发布物品</h1><hr />
                    <div class="changeinfo">
                        <%--<span>物品名：</span>--%>
                        <input class="in_info" type="text" name="name" placeholder="请输入物品名"/>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <%--<span>出售价格：</span>--%>
                        <input class="in_info" type="text" name="price" placeholder="请输入出售价格"/>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <%--<span>原价：</span>--%>
                        <input class="in_info" type="text" name="realPrice" placeholder="请输入商品原价"/>
                        <span id="checkphone">(*选填,请如实填写)</span>
                    </div>
                    <div class="changeinfo">
                        <span>物品类别：</span>
                        <select class="in_info" name="catelogId">
                            <option value="1">闲置数码</option>
                            <option value="2">校园代步</option>
                            <option value="3">电器日用</option>
                            <option value="4">图书教材</option>
                            <option value="5">美妆饰品</option>
                            <option value="6">运动棋牌</option>
                            <option value="7">衣物箱包</option>
                        </select>
                    </div>
                    <div class="changeinfo" id="dir">
                        <span>商品描述：</span>
                        <div class="sha">
                            <div class="publ">
                                <div class="pub_con">
                                    <div class="text_pu">
                                        <textarea name="describle" class="emoji-wysiwyg-editor"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <hr />
                    <div class="changeinfo">
                        <span>商品图片：</span>
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                            <input type="file" name="myfile" data-ref="imgUrl" class="col-sm-10 myfile" value=""/>
                                            <input type="hidden" name="imgUrl" value="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="submit" class="setting-save" value="发布物品" style="margin-top: 20px;background-color: blue;"/>
                </form:form>
            </div>


                <%--描述：最右侧，可能认识的人--%>

            <%--<div class="recommend">--%>
                <%--<div class="title">--%>
                    <%--<span class="text">可能认识的人</span>--%>
                    <%--<span class="change">换一组</span>--%>
                    <%--<span class="underline"></span>--%>
                <%--</div>--%>
                <%--<ul>--%>
                    <%--<li>--%>
                        <%--<a href="" class="head_img">--%>
                            <%--<img src="<%=basePath%>img/photo1.jpg">--%>
                        <%--</a>--%>
                        <%--<span>Brudce</span>--%>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="" class="head_img">--%>
                            <%--<img src="<%=basePath%>img/photo2.jpg">--%>
                        <%--</a>--%>
                        <%--<span>Graham</span>--%>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="" class="head_img">--%>
                            <%--<img src="<%=basePath%>img/photo3.jpg">--%>
                        <%--</a>--%>
                        <%--<span>策马奔腾hly</span>--%>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="" class="head_img">--%>
                            <%--<img src="<%=basePath%>img/photo4.jpg">--%>
                        <%--</a>--%>
                        <%--<span>Danger-XFH</span>--%>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="" class="head_img">--%>
                            <%--<img src="<%=basePath%>img/photo5.jpg">--%>
                        <%--</a>--%>
                        <%--<span>Keithw</span>--%>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <div id="t1" style="display:none" class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class ="change">
                    <input type="button" value="换一组" id="btn" class="btn btn-success btn-xs" style="width: 40px;height: 24px; padding-left: 0px;border-left-width: 1px;padding-right: 0px;" onclick="show(t2);"/>
                    </span>
                    <%--<span class="change">换一组</span>--%>
                    <%--<span class="underline"></span>--%>
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped active" role="progressbar" id="test1" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
                            <span class="sr-only">45% Complete</span>
                        </div>
                    </div>
                </div>
                <ul>
                    <li>
                        <%--<button type="button" class="head_img" onclick="viewPersonal(25)"></button>--%>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[5].id})">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>${users[5].username}</span>
                        <%--点赞（未实现）--%>
                        <%--<div class="glyphicon glyphicon-thumbs-up btn-lg"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[6].id})">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>${users[6].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[7].id})">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>${users[7].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[8].id})">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>${users[8].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[9].id})">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>${users[9].username}</span>
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
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped active" id="test" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
                            <span class="sr-only">45% Complete</span>
                        </div>
                    </div>
                </div>

                <ul>

                    <li>
                        <%--<button type="button" class="head_img" onclick="viewPersonal(25)"></button>--%>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[0].id})">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>${users[0].username}</span>
                        <%--点赞（未实现）--%>
                        <%--<div class="glyphicon glyphicon-thumbs-up btn-lg"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[1].id})">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>${users[1].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[2].id})">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>${users[2].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[3].id})">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>${users[3].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                    <li>
                        <a href="#" class="head_img" role="button" onclick="viewPersonal(${users[4].id})">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>${users[4].username}</span>
                        <%--<div class="fa fa-plus-square"></div>--%>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    $(".myfile").fileinput({
        uploadUrl:"<%=basePath%>goods/uploadFile",//上传的地址
        uploadAsync:true, //默认异步上传
        showUpload: false, //是否显示上传按钮,跟随文本框的那个
        showRemove : false, //显示移除按钮,跟随文本框的那个
        showCaption: true,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        dropZoneEnabled: true,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        //minImageWidth: 50, //图片的最小宽度
        //minImageHeight: 50,//图片的最小高度
        //maxImageWidth: 1000,//图片的最大宽度
        //maxImageHeight: 1000,//图片的最大高度
        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
        //minFileCount: 0,
        maxFileCount: 3, //表示允许同时上传的最大文件个数
        enctype: 'multipart/form-data',
        validateInitialCount:true,
        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        allowedFileTypes: ['image'],//配置允许文件上传的类型
        allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
        allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
        language : 'zh'
    })
    //异步上传返回结果处理
    $('.myfile').on('fileerror', function(event, data, msg) {
        console.log("fileerror");
        console.log(data);
    });
    //异步上传返回结果处理
    $(".myfile").on("fileuploaded", function (event, data, previewId, index) {
        console.log("fileuploaded");
        var ref=$(this).attr("data-ref");
        $("input[name='"+ref+"']").val(data.response.imgUrl);
    });

    //同步上传错误处理
    $('.myfile').on('filebatchuploaderror', function(event, data, msg) {
        console.log("filebatchuploaderror");
        console.log(data);
    });

    //同步上传返回结果处理
    $(".myfile").on("filebatchuploadsuccess", function (event, data, previewId, index) {
        console.log("filebatchuploadsuccess");
        console.log(data);
    });

    //上传前
    $('.myfile').on('filepreupload', function(event, data, previewId, index) {
        console.log("filepreupload");
    });
</script>
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