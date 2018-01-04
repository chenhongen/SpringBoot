<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公用引入 -->
		<%@include file="../common.jsp" %>
		<title>功能资源权限分配</title>
	</head>
<body>
	<!-- <div class="nav_funcauth">&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton margin-10" iconCls="icon-save" onclick="save_funcauth()">保存</a>
	</div>
	<br/>
	
	<ul id="funcauthTree" checkbox="true" animate="true"></ul> -->
	
	<div class="mini-fit" style="padding:10px;">
	<div id="panel1" class="mini-panel" style="width:100%;height:100%;" showHeader="false"
	    showToolbar="true" showCollapseButton="false" showFooter="false">
	    <!--toolbar-->
	    <div property="toolbar" style="padding:10px;">
	    	<table style="width:100%;">
	                <tr>
	                <td style="width:100%;">
	                	<a class="mini-button" iconCls="icon-save" onclick="saveTree" title="保存"></a>
	                	<span class="separator"></span>
				        <a class="mini-button" iconCls="icon-expand" onclick="expandAll()" title="全部展开"></a>
						<a class="mini-button" iconCls="icon-collapse" onclick="collapseAll()" title="全部折叠"></a>
	                </td>
	                <td style="white-space:nowrap;">
	                	<input id="key" class="mini-textbox" style="width:100px;" onenter="onKeyEnter" emptyText="请输入查询条件" />
						<a class="mini-button" style="width:60px;" iconCls="icon-search" onclick="search()">查询</a>
	                </td>
	            </tr>
	        </table> 
	    </div>
	    <!--body-->
	 	<div class="mini-fit" style="padding:0px 10px 10px 10px;">
			<ul id="funcTree" class="mini-tree" style="width:100%;height:100%;"
				url="${pageContext.request.contextPath}/resauth/listResTree"
				idField="id" textField="text" parentField="pid" resultAsTree="false"
				showTreeIcon="true" ajaxData="setRoleId" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" checkRecursive="true">
			</ul>
		</div>
	</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var roleId = ${param.roleId},
			funcTree = mini.get("funcTree");
		funcTree.expandLevel(0);
		
		// 先于上述执行
		function setRoleId(){
			return {"roleId": ${param.roleId}};
		}
		
		function expandAll(){
			funcTree.expandAll();
		}

		function collapseAll(){
			funcTree.collapseAll();
		}
		
		function saveTree(){
			var funcDatas = funcTree.getCheckedNodes();
			var leafNodes = new Array();
			for(var cursor = 0; cursor < funcDatas.length; cursor++){
				var node = funcDatas[cursor];
				if(funcTree.isLeaf(node)){
					delete node.expanded;
					delete node._id;
					delete node._uid;
					delete node._pid;
					delete node._level;
					leafNodes.push(node);
				}
			}
			var json = mini.encode({datas: leafNodes, roleId: roleId});

	        $.ajax({
	            url: mini.contextPath + "/resauth/saveResauth",
	            type: 'POST',
	            dataType: 'json',
	            data: {"datas": mini.encode(leafNodes), "roleId": roleId},
	            cache: false,
	            //contentType:'application/json',
	            success: function (text) {
	            	mini.alert("权限设置成功");
	            },
	            error: function () {
	            	mini.alert("权限设置失败");
	            }
	        });
		}
		<%--
		var roleId = "<%=request.getParameter("id")%>";
		//懒加载应用功能树
		$('#funcauthTree').tree({
			onBeforeExpand: function(node){
				var ns = $('#funcauthTree').tree('getChildren',node.target);
				if(ns.length<1){
					load_data(node);
				}
			}
			
		});
		//加载树 数据
		function load_data(node){
			$.ajax({
		 		url: '<%=request.getContextPath() %>/resauth/reslist.do',
		 		type: 'POST',
		 		data: {'roleId':roleId,'id':node.id,'type':node.type},
		 		dataType: 'json',
		 		traditional: true,//这里设置为true
		 		async:false,
		 		success: function(data){
		 			if(data.data.length){//非空
						$('#funcauthTree').tree('append', {
							parent: node.target,
							data:data.data
						});
		 			}else{
		 				remove(node);
		 			}
		 		},
		 		error: function(jqXHR, textStatus, errorThrown){
		 			
		 		}
		 	});
		}
		/**
		 * 删除节点方法
		 * 如果节点下无子节点，则删除
		 * 并且搜寻其父节点。
		 */
		function remove(node){
			if(node.type == "group"){
				var c_ns = $('#funcauthTree').tree('getChildren',node.target);
				if(c_ns.length < 1){
					var p_n = $('#funcauthTree').tree('getParent',node.target);
					$('#funcauthTree').tree('remove',node.target);
					/* if(p_n.type == "app"){//tree-icon tree-folder 设置节点图标为文件夹
						$(p_n.target).children().eq(2).attr('class', 'tree-icon tree-folder');
					} */
					remove(p_n);
				}
			}
		}
		
		//定义树的根节点
		var rootNode = [{id:'0', text:'应用功能树',state: 'closed',type:'root'}];
		$(function(){
			$("#funcauthTree").tree('append', {
				data: rootNode
			});
			//展开所有节点
			expandAll($("#funcauthTree").tree('getRoot'));
			$("#funcauthTree").tree('collapseAll', $("#funcauthTree").tree('getRoot').target);
			//展开根结点
			var expandNode = $("#funcauthTree").tree('getRoot');
			$("#funcauthTree").tree('expand', expandNode.target);
			
		});//[END]
		//展开所有节点方法
		function expandAll(node){
			$("#funcauthTree").tree('expand', node.target);
			var nodes = $("#funcauthTree").tree('getChildren', node.target);
			var i = nodes.length;
			if(i>0){
				for(var n=0;n<i;n++){
					expandAll(nodes[n]);
				}
			}
		}
		//保存选中的功能资源
		function save_funcauth(){
			var check = new Object();
			var checks = $('#funcauthTree').tree('getChecked');
			//将选中的功能资源放datas里
			var datas = [];
			for(var i=0;i<checks.length;i++){
				if(checks[i].type=="func"){
					check.id = checks[i].id;
					check.type = checks[i].type;
					check.state = "1";
					check.text = checks[i].text;
					check.isCheck = checks[i].isCheck;
					var obj = JSON.stringify(check);
					datas.push(obj);
				}
			}

			//未选中任何信息
			if(datas.length<1){
				deleteAll(roleId);
			}else{
				var saveUrl = '<%=request.getContextPath() %>/resauth/saveResauth.do';
				saveCheck(roleId,datas,saveUrl);
			}
		}
		function deleteAll(roleId){//未选中任何信息，即全部删除
			$.ajax({
		 		url: '<%=request.getContextPath() %>/resauth/removeResauth.do',
		 		type: 'POST',
		 		data: {"roleId":roleId},
		 		dataType: 'json',
		 		traditional: true,//这里设置为true
		 		success: function(result){
		 			if (result.result == "SUCCESS") {
						$.messager.alert('提示信息', "未选中任何功能信息，已取消全部授权！", 'info');
						$("#funcauthTree").tree('uncheck', $("#funcauthTree").tree('getRoot').target);
					} else {
						$.messager.alert('提示信息', getMessage("SAVE_FAIL"), 'error');
					}
		 		},
		 		error: function(jqXHR, textStatus, errorThrown){
		 		}
		 	});
		}
		function saveCheck(roleId,datas,saveUrl){//保存选中的信息
			$.ajax({
		 		url: saveUrl,
		 		type: 'POST',
		 		data: {"roleId":roleId,"datas":datas},
		 		dataType: 'json',
		 		traditional: true,//这里设置为true
		 		success: function(result){
		 			if (result.result == "SUCCESS") {
						$.messager.alert('提示信息', getMessage("SAVE_SUCCESS"), 'info');
					} else {
						$.messager.alert('提示信息', getMessage("SAVE_FAIL"), 'error');
					}
		 		},
		 		error: function(jqXHR, textStatus, errorThrown){
		 		}
		 	});
		} --%>
	
	</script>
</body>
</html>