<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公用引入 -->
		<%@include file="../common.jsp" %>
		<title>授权管理</title>
	</head>
<body>
	<!-- <div id="authmanagePanel" class="easyui-layout appmain"  fit="true">
		left start
		<div class="main-left" region="west" split="true" title="授权管理" style="width:300px;">
			
			<table id="rolelist_authGrid" fit="true" pagination="true" striped="true"
					rownumbers="true"  singleSelect="true" fitColumns="true">
				<thead>
					<tr>
						<th field="roleId" hidden="true"></th>
						<th field="roleName" width="100">角色名称</th>
						<th field="roleCode" width="100">角色代码</th>
						<th field="roledesc" data-options="formatter:formatAuthUrl" width="100">授权</th>
					</tr>
				</thead>
			</table>
		
		</div>
		left end
		right start
		<div region="center" border="true" class="main-right">
			
			<div id="authmanageTab" class="easyui-tabs main-tab" fit="true">
				<div id="org_tab1" title="功能" class="padding-10" ></div>
				<div id="org_tab2" title="员工" class="padding-10"></div>
			</div>
			
		</div>
		right end
	</div> -->
	
	<div class="mini-fit" style="width:100%; height:100%; padding:0;">
		<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
			<div id="region1" region="west" title="角色授权" showHeader="true" class="sub-sidebar" width="400" allowResize="false">
				<div class="mini-fit" style="padding:0;">
					<div id="roleGrid" class="mini-datagrid" style="width:100%;height:99%;"
						url="<%=request.getContextPath() %>/role/listCapRoleByCriteria" 
						idField="roleId" multiSelect="true" allowAlternating="true" showPager="false"
						showReloadButton="false" showPageSize="false" showPageInfo="false"
						ondrawcell="drawRoleAuthConfig">
						<div property="columns">
							<div field="roleCode" width="38%">角色代码</div>
							<div field="roleName" width="38%">角色名称</div>
							<div name="roleAuthConfig" width="24%">授权配置</div>
						</div>
					</div>
				</div>
			</div>
			<div title="center" region="center" style="border:0;padding-left:5px;padding-top:5px;">
				<div id="authTabs" class="mini-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;" onactivechanged="changeTab">
					<div id="fun_tab" name="fun_tab" title="功能" ></div>
					<div id="emp_tab" name="emp_tab" title="员工" ></div>
				</div>
			</div>
		</div>		
	</div>
<script type="text/javascript">
	mini.parse();
	var authTabArray = [{name: "fun_tab", title: "功能", path: mini.contextPath+"function_auth"}
					, {name: "emp_tab", title: "员工", path: mini.contextPath+"employee_auth"}],
		roleGrid = mini.get("roleGrid"),
		authTabs = mini.get("authTabs");
	
	roleGrid.load();
	
	// 装载选定角色相应的tab页
	function reloadTab(paramObj){
		for(var i = 0; i < authTabArray.length; i++){
			var authTabElem = authTabArray[i];
			var settingTab = authTabs.getTab(i);
			settingTab.url = setUrlParam(authTabElem.path, paramObj);
		}
		var currentTab = authTabs.getActiveTab();
		authTabs.reloadTab(currentTab);
	}
	
	// 设置Tab的URL及参数 
	function setUrlParam(url,paramObj){
		if(!url){
			return url;
		}
		var params = [];
		for(var pop in paramObj){
			params.push(pop + "=" + paramObj[pop]);
		}
		var paramStr = params.join("&");
		if(url.indexOf("?")>=0){
			return url + "&" + paramStr;
		}else{
			return url + "?" + paramStr;
		}
	}
	
	function changeTab(e){
		authTabs.reloadTab(e.tab);
	}
	
	function drawRoleAuthConfig(e){
		if(e.column.name == "roleAuthConfig"){
			e.cellHtml = "<a style='color:#1B3F91;text-decoration:underline;' href='#' id='"+e.record.roleId+"' onclick='authConfig(this)'>配置</a>";
		}
	}

	function authConfig(obj){
		var layout1 = mini.get("layout1");
		var paramObj = {roleId:obj.id};
		reloadTab(paramObj);
	}
<%-- 	$(function(){
		$("#rolelist_authGrid").datagrid({
			url:'<%=request.getContextPath() %>/role/listCapRole.do'
		}).datagrid('tooltip');
		
		var pager = $('#rolelist_authGrid').datagrid('getPager');    // get the pager of datagrid
		pager.pagination({
			pageSize: 20,
			showRefresh:false,
			displayMsg:''
		});
	});

	function formatAuthUrl(value,rowData,rowIndex){
	    //function里面的三个参数代表当前字段值，当前行数据对象，行号（行号从0开始）
	    return "<a href='javascript:void(0);' style='color:#4DBAE3;' onclick='manageRole("+rowData.roleId+")'>操作</a>";
	}
	
	function manageRole(id){
		$("#authmanagePanel").layout('collapse','west');
		authfreshTab(id);
	}
	
	var funcUrl = '<%=request.getContextPath() %>/auth/authmanage/funcauth.jsp';
	var userUrl = '<%=request.getContextPath() %>/auth/authmanage/partyauth.jsp';
	
	//更新tab页
	function authfreshTab(id){
		var funchref = funcUrl+"?id="+id;
		//var content = '<iframe scrolling="auto" frameborder="0"  src="'+funchref+'" style="width:100%;height:100%;"></iframe>';
		$('#authmanageTab').tabs('update',{
			tab: $('#authmanageTab').tabs('getTab',0),
			options: {
				href: funchref
			}
		});
		var partyhref = userUrl+"?id="+id;
		//var content = '<iframe scrolling="auto" frameborder="0"  src="'+partyhref+'" style="width:100%;height:100%;"></iframe>';
		$('#authmanageTab').tabs('update',{
			tab: $('#authmanageTab').tabs('getTab',1),
			options: {
				href: partyhref
			}
		});
		$('#authmanageTab').tabs('getTab',0).panel('refresh');
		$('#authmanageTab').tabs('select',0);
	} --%>
</script>	

</body>
</html>