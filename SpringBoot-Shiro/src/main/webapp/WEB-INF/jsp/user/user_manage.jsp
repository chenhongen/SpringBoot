<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公用引入 -->
		<%@include file="../common.jsp" %>
		<title>用户列表</title>
	</head>
<body>
 <div class="search-condition">
    <table id="searchFrom" class="table">
      <tr>
        <td class="tit">&nbsp;&nbsp;用户名称：</td>
        <td>
          <input class="mini-textbox" name="criteria.criterion[0].value"/>
          <input class="mini-hidden" name="criteria.criterion[0].property" value="userName" />
          <input class="mini-hidden" name="criteria.criterion[0].condition" value="like"/>
          <input class="mini-hidden" name="criteria.criterion[0].likeAll" value="true"/>
        </td>
        <td class="tit">&nbsp;&nbsp;用户状态：</td>
        <td>
          <input class="mini-dictcombobox" valueField="dictid" textField="dictname" emptyText="全部"
          	dictTypeId="USER_STATUS" name="criteria.criterion[1].value" showNullItem="true" nullItemText="全部"/>
          <input class="mini-hidden" name="criteria.criterion[1].property" value="status" />
          <!-- criteria.criterion[0]操作符缺省值为“=” -->
        </td>
        <td class="btn-wrap">
          <a class="mini-button" iconCls="icon-search" onclick="search">查询</a>
        </td>
      </tr>
    </table>
  </div>
  
  <div class="mini-toolbar" style="border-bottom:0;padding:0;">
  	<table>
    	<tr>
           <td>
             <a class="mini-button" iconCls="icon-add" onclick="add">增加</a>
		     <a class="mini-button" iconCls="icon-edit" onclick="update" id="update" >编辑</a>
		     <a class="mini-button" iconCls="icon-remove" onclick="remove">删除</a>
		     <span class="separator"></span>   
		     <a class="mini-button" iconCls="icon-change-password" onclick="resetPassword">重置密码</a>
           </td>
        </tr>
  	</table>
  </div>
  
  <div class="mini-fit">
	 <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" idField="operatorId"
	  url="<%=request.getContextPath() %>/user/listUserByCriteria"
	  sizeList=[5,10,20,50,100] multiSelect="true" pageSize="10" onselectionchanged="selectionChanged">
	    <div property="columns" >
	      <div type="checkcolumn"></div>
	      <div field="userId" headerAlign="center">登录用户名</div>
	      <div field="userName" headerAlign="center">用户名称</div>
	      <!-- <div field="authmode" headerAlign="center" renderer="renderAuthmode">认证模式</div> -->
	      <div field="status" headerAlign="center" renderer="renderStatus">用户状态</div>
	      <div field="email" headerAlign="center">邮箱</div>
	      <div field="createuser" headerAlign="center">创建人</div>
	    </div>
	 </div>
  </div>
  
  <script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid1");
    var form = new mini.Form("#searchFrom");
	
    grid.load();
    
    // 查询
    function search(){
    	var data = form.getData(false, false);
    	grid.load(data);
    }
    
    // 新增
    function add(){
       mini.open({
          //url:mini.contextPath+"/user/user_add.jsp",
          url:"user/user_detail",
          title:'新增用户',
          width:610,
          height:267,
          allowResize:false,
          onload:function(){ },
          ondestroy:function(action){
             if(action === "saveSuccess"){
	            grid.reload();
	         }
          }
       });
    }
    
    // 更新
    function update(){
       var row = grid.getSelected();
       if(row){
	       mini.open({
	          url:"user/user_detail",
	          title:'编辑用户',
	          width:610,
	          height:267,
	          allowResize:false,
	          onload:function(){
	             var iframe = this.getIFrameEl();
	             var data = row;
	             iframe.contentWindow.setData(data);
	          },
	          ondestroy:function(action){
	             if(action=="saveSuccess"){
	                grid.reload();
	             }
	          }
	       });
       }else{
           mini.alert("请选中一条记录！", "系统提示");
       }
    }
    
    // 删除
    function remove(){
      var rows = grid.getSelecteds();
      if(rows.length > 0){
         mini.confirm("确定删除选中记录？","系统提示",
           function(action){
             if(action === "ok"){
	            var a = mini.loading("正在删除中,请稍等...", "系统提示");
		        $.ajax({
		          url:mini.contextPath + "/user/deleteUserByKey",
		          type:'POST',
		          dataType: "json",
		          data:mini.encode(rows),
		          cache: false,
		          contentType:'application/json',
		          success:function(text){
		          	mini.hideMessageBox(a);
		            var returnJson = mini.decode(text);
					if(mini.consts[returnJson.result]){
						mini.alert("删除用户成功", "系统提示", function(action){
							grid.reload();
						});
					}else{
						mini.alert("删除用户失败", "系统提示");
						grid.unmask();
					}
		          }
		        });
		     }
		   });
      }else{
        mini.alert("请选中一条记录！");
      }
    }
    
    // 重置密码：000000
    function resetPassword(){
       var rows = grid.getSelecteds();
       if(rows.length>0){
	       mini.confirm("确定将密码重置为000000？","系统提示",
           function(action){
             if(action=="ok"){
	            var a= mini.loading("正在重置中,请稍等...","提示");
		        $.ajax({
		        	url:mini.contextPath + "/user/updateUserPassword",
		        	type:'POST',
		        	dataType: "json",
			        data:mini.encode(rows),
			        cache: false,
			        contentType:'application/json',
		        	success:function(text){
		          	mini.hideMessageBox(a);
			            var returnJson = mini.decode(text);
			            if(mini.consts[returnJson.result]){
							mini.alert("重置密码成功", "系统提示", function(action){
								grid.reload();
							});
						}else{
							mini.alert("重置密码失败", "系统提示");
							grid.unmask();
						}
		        	}
		        });
		     }
		   });
       }else{
           mini.alert("请选中一条记录！", "系统提示");
       }
    }
    
    // 数据字典渲染
    function renderStatus(e){
       return mini.getDictText("USER_STATUS",e.row.status);
    }
    
    // 行修改
    function selectionChanged(){
       var rows = grid.getSelecteds();
       if(rows.length>1){
           mini.get("update").disable();
       }else{
           mini.get("update").enable();
       }
    }
  </script>
</body>
</html>