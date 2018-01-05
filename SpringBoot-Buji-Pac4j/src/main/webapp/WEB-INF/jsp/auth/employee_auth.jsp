<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公用引入 -->
		<%@include file="../common.jsp" %>
		<title>员工授权</title>
	</head>
<body>
<div class="mini-fit" style="padding:10px;">
	<div id="employeeForm">
		<div class="mini-toolbar" style="text-align:left;line-height:30px;padding:5px 0px 5px 10px;" borderStyle="border-bottom:0;">
			<table id="employeeToolBar">
				<tr>
					<td style="width:1px;"></td>
					<td style="width:60px;"><a id="btn_save" class="mini-button" iconCls="icon-save" onclick="saving();">保存</a></td>
					<td></td>
					<td style="width:60px; text-align:right;">机构名称：</td>
					<td style="width:100px;">
						<input class="mini-textbox" name="criteria.criterion[0].value"  emptyText="机构名称" style="width:100px;" />
						<input class="mini-hidden" name="criteria.criterion[0].property" value="orgname" />
						<input class="mini-hidden" name="criteria.criterion[0].condition" value="like" />
						<input class="mini-hidden" name="criteria.criterion[0].likeAll" value="true" />
					</td>
					<td style="width:60px; text-align:right;">员工姓名：</td>
					<td style="width:100px;">
						<input class="mini-textbox" name="criteria.criterion[1].value" emptyText="员工姓名" style="width:100px;" />
						<input class="mini-hidden" name="criteria.criterion[1].property" value="empname" />
						<input class="mini-hidden" name="criteria.criterion[1].condition" value="like" />
						<input class="mini-hidden" name="criteria.criterion[1].likeAll" value="true" />
						<input class="mini-hidden" name="roleId" value="${roleId}" />
					</td>
					<td style="width:70px; text-align:right;"><input class="mini-button" iconCls="icon-search" text="查询" onclick="searchEmployee" /></td>
					<td style="width:10px;"></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="mini-fit">
		<div id="employeeGrid" class="mini-datagrid" style="width:100%;height:100%;"  onload="onGridLoad"
			url="${pageContext.request.contextPath}/partyauth/queryAuthEmp"
			idField="empid" allowResize="false" allowCellEdit="true" sizeList="[10,20,30]" pageSize="20" multiSelect="true">
		    <div property="columns">
		        <div field="empcode" width="120" headerAlign="center" >员工编号</div>
		        <div field="empname" width="120" headerAlign="center" >员工姓名</div>
		        <div field="orgname" width="120" headerAlign="center" allowSort="true">所属机构</div>
		        <div type="checkboxcolumn" field="auth" width="120" trueValue=1 falseValue=0>授权</div>
		    </div>
		</div>
	</div>
</div>
	
	<script type="text/javascript">
		mini.parse();
		var employeeGrid = mini.get("employeeGrid");
		var pageSize = employeeGrid.getPageSize();
		var roleIdData = "<%=request.getParameter("roleId")%>";
		employeeGrid.load({"roleId":roleIdData});
		
		// 保存
		function saving(){
			var employeeWithAuth = [];
			var employeeNoAuth = [];
			var employeeData = employeeGrid.getChanges();
			for(var i = 0; i < employeeData.length; i++){
				var fieldNode = {partyType:"emp", empid:employeeData[i].empid, empcode:employeeData[i].empcode, empname:employeeData[i].empname};
				if(employeeData[i].auth == "1"){
					employeeWithAuth.push(fieldNode);
				}else{
					employeeNoAuth.push(fieldNode);
				}
			}
			var sendData = {roleId:roleIdData, partyWithAuth:employeeWithAuth, partyNoAuth:employeeNoAuth};
			$.ajax({
				url: mini.contextPath + "/partyauth/saveAuth",
				type: "POST",
				data: mini.encode(sendData),
				cache: false,
				dataType : 'json',
		 		contentType : 'application/json',
				success: function(text){
					if(text.result=="SUCCESS"){
						mini.alert("权限设置成功");
					}else{
						mini.alert("权限设置失败");
					}
				},
				error: function(jqXHR, textStatus, errorThrown){}
			});
		}

		function searchEmployee(){
			var employeeForm = new mini.Form("#employeeForm");
			var employeeFormData = employeeForm.getData(false, false);
			employeeGrid.load(employeeFormData);
		}
		
		function onGridLoad(){
			var data = employeeGrid.getData();
			mini.get("btn_save").set({"enabled":(data.length>0)});
		}
	</script>
</body>
</html>