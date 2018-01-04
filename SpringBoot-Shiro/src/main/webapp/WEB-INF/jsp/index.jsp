<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<!-- 公用引入 -->
		<%@include file="common.jsp" %>
		<style>
			body {
			    border: 0 none;
			    height: 100%;
			    margin: 0;
			    overflow: hidden;
			    padding: 0;
			    width: 100%;
			}
			
			.header {
			    background: rgba(0, 0, 0, 0) url("../images/head.gif") repeat-x scroll 0 -1px;
			    height: 40px;
			    min-width: 908px;
			    padding: 10px 0;
			}
			.head-box {
			    height: 40px;
			    margin: 0 auto;
			    min-width: 828px;
			    padding: 0 40px;
			    position: relative;
			    z-index: 1290;
			}
			.head-logo {
			    float: left;
			    height:40px;line-height:40px;padding-left:15px;font-family:Tahoma;font-size:16px;font-weight:bold;
			}
			.head-right {
			    float: right;
			    line-height:40px;
			    padding: 0 20px;
			}
		</style>
		<title></title>
	</head>
	<body>
	<div class="header" >        
        <div class="head-logo">
        	EMES
        </div>
        <div class="head-right">
	        <shiro:user>  
				欢迎[<shiro:principal/>]，<a href="${pageContext.request.contextPath}/logout">退出</a>  
			</shiro:user>
		</div>
    </div>
    <div class="mini-fit" style="padding-top:5px;">
    	<shiro:authenticated> 
        <!--Tabs-->
        <div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;"      
                 
        > 
            <div title="首页" url="/user/listUserByCriteria" >        
            </div>
        </div>   
        </shiro:authenticated> 
    </div>
    <div style="line-height:28px;text-align:center;cursor:default">Copyright © xx </div>
    
	<script type="text/javascript">
	    mini.parse();
	    
	    (function(){
	    	mini.context='<%=contextPath %>'
	    })();
	
	    function showTab(node) {
	        var tabs = mini.get("mainTabs");
	
	        var id = "tab$" + node.id;
	        var tab = tabs.getTab(id);
	        if (!tab) {
	            tab = {};
	            tab.name = id;
	            tab.title = node.text;
	            tab.showCloseButton = true;
	
	            //这里拼接了url，实际项目，应该从后台直接获得完整的url地址
	            tab.url = mini.context + "/router/" + node.path;
				tabs.addTab(tab);
	        }
	        tabs.activeTab(tab);
	    }
	    
	    function onItemClick(e) {        
	        var item = e.item;
	        var isLeaf = e.isLeaf;
	
	        if (isLeaf) {
	            showTab(item);
	        }            
	    }
	</script>
	</body>
</html>