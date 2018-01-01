<!--login_page_identity-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="0">
		<link rel="stylesheet" type="text/css" href="../open/demo.css">
		<title></title>
		
		<script>
			//判断当前窗口是否有顶级窗口，如果有就让当前的窗口的地址栏发生变化, 防止内联跳转
		    if (window.top!=null && window.top.document.URL!=document.URL){
		        window.top.location= document.URL; //这样就可以让登陆窗口显示在整个窗口了   
		    }
		</script>
	</head>
	<body>
		
	<div class="login-form w3_form">
		<!--  Title-->
		<div class="login-title w3_title">
	    	<h1>TEST</h1>
	    </div>
		<div class="login w3_login">
		    <h2 class="login-header w3_header">登 陆</h2>
			<div class="w3l_grid">
	        	<form id="ff" method="post" class="login-container" role="form">
	            	<input placeholder="用户名" name="userId" id="userId" required type="text" autofocus>
	                <input placeholder="密码" name="password" id="password" required type="password">
	                <!-- <input value="Submit" type="submit"> -->
	                <button id="submitBtn" type="button" onclick="submitForm()">登录</button>
				</form>
				<div class="bottom-header w3_bottom"></div>            
				<div class=" bottom-text w3_bottom_text">
				      <p>没有账号？<a href="#">注册</a></p>
				      <h4> <a href="#">忘记密码？</a></h4>
				</div>
			</div>
		</div>
	</div>
		
	<script>
		var contextPath = "<%=request.getContextPath() %>";
		// 登陆
		function submitForm(){
	    	var userId = $("#userId").val();
        	var password = $("#password").val();
        	if(userId == null || userId == ""){
        		mini.alert('用户名不能为空!','警告');
        		return;
        	}
        	
        	if(password == null || password == ""){
        		mini.alert('密码不能为空!','警告');
        		return;
        	}
        	$.ajax({
        		url: contextPath + '/login',
        		type: 'POSt',
        		data: $('#ff').serialize(),
        		cache: false,
        		async: false,
        		dataType: 'json',
        		success: function(data){
        			if(data.result == "SUCCESS"){
        				location.href = contextPath + "/router/index";
        			}else{
        				mini.alert('用户名或密码错误!','系统提示', function(){
        					clearForm();
        				});
        			}
        		},
        		error: function(jqXHR, textStatus, errorThrown){
        			mini.alert('用户名或密码错误!','系统提示');
        		}
        	});
	    }
	    
		// 重置
	    function clearForm(){
	    	$("#ff")[0].reset();
	    }

	    // 绑定回车事件
	    $('#password').bind('keydown',function(event){
	        if(event.keyCode == "13") {
	        	submitForm();
	        }
	    });
	</script>
	</body>
</html>