<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公用引入 -->
		<%@include file="../common.jsp" %>
		<title>用户详情</title>
	</head>
<body>
  <div id="form1" style="padding-top:5px;">
    <input class="mini-hidden" name="operatorId"/>
    <table style="width:100%;height:100%;table-layout:fixed;" class="mini-form-table">
      <tr>
        <th class="mini-form-label"><label for="userId$text">用户登录名：</label></th>
        <td>
          <input id="userId" class="mini-textbox mini-form-input" name="userId" required="true" vtype="maxLength:30" onvalidation="onCheck"/>
        </td>
        <th class="mini-form-label"><label for="userName$text">用户名称：</label></th>
        <td>
          <input id="userName" class="mini-textbox mini-form-input" name="userName"/>
        </td>
      </tr>
      <tr class="odd">
        <th class="mini-form-label"><label for="password$text">登录密码：</label></th>
        <td>
          <input id="password" class="mini-password mini-form-input" name="password" value="000000" required="true"/>
        </td>
        <th class="mini-form-label"><label for="invaldate$text">密码失效日期：</label></th>
        <td>
          <input id="invaldate" class="mini-datepicker mini-form-input" name="invaldate" allowInput="false" alwaysview="true"/>
        </td>
      </tr>
      <tr>
        <th class="mini-form-label"><label for="startdate$text">有效开始时间：</label></th>
        <td>
          <input id="startdate" class="mini-datepicker mini-form-input" name="startdate" allowInput="false" alwaysview="true"/>
        </td>
        <th class="mini-form-label"><label for="enddate$text">有效截止时间：</label></th>
        <td>
          <input id="enddate" class="mini-datepicker mini-form-input" name="enddate" onvalidation="onCompare" allowInput="false" alwaysview="true"/>
        </td>
      </tr>
      <tr class="odd">
        <th class="mini-form-label"><label for="email$text">邮箱地址：</label></th>
        <td>
          <input id="email" class="mini-textbox mini-form-input" name="email" vtype="email"/>
        </td>
        <th class="mini-form-label"><label for="status$text">用户状态：</label></th>
        <td>
          <input id="status" class="mini-dictcombobox mini-form-input" name="status" value="N"
          	valueField="dictid" textField="dictname" dictTypeId="USER_STATUS"/>
        </td>
      </tr>
      <tr>
        <th class="mini-form-label"><label for="ipaddress$text">IP地址：</label></th>
        <td colspan="3">
          <input id="ipaddress" class="mini-textarea mini-form-input" name="ipaddress"/>
        </td>
      </tr>
    </table>
    <div class="mini-toolbar" style="padding:0;" borderStyle="border:0;">
	    <table width="100%">
	      <tr>
	        <td style="text-align:center;">
	          <a class="mini-button" iconCls="icon-save" onclick="save">保存</a>
	          <span style="display:inline-block;width:25px;"></span>
	          <a class="mini-button" iconCls="icon-cancel" onclick="onCancel">取消</a>
	        </td>
	      </tr>
	    </table>
	 </div>
  </div>

  <script type="text/javascript">
    mini.parse();
    var obj,form = new mini.Form("#form1");
    
    form.setChanged(false);
    
    // 更新时，数据初始化
    function setData(data){
        data = mini.clone(data);
        $.ajax({
          url:mini.contextPath + "/user/getUser",
          type:'POST',
          data:{operatorId: data.operatorId},
          cache:false,
          success:function(text){
            obj = mini.decode(text);
            form.setData(obj.data);
            form.setChanged(false);
          }
        });
    }   
    
    // 保存
    function save(){  
      form.validate();
      if(form.isValid()==false) return;
      
      var data = form.getData(false,true);
      var json = mini.encode(data);
      var url = "/user/insertUser";
      if(obj != null) {
    	  url = "/user/updateUser";
      }
      $.ajax({
        url:mini.contextPath + url,
        type:'POST',
        data:json,
        cache:false,
        contentType:'application/json',
        success:function(text){
            var returnJson = mini.decode(text);
            if(mini.consts[returnJson.result]){
				mini.alert("操作成功！", "系统提示", function() {
					CloseWindow("saveSuccess");
				});
			}else{
				mini.alert("操作失败！", "系统提示");
			}
        }
      });
    }
    
    // 取消
    function onCancel(){
      CloseWindow("cancel");
    }
    
    // 窗口关闭
    function CloseWindow(action){
      if(action=="close" && form.isChanged()){
        if(confirm("数据已改变,是否先保存?")){
          return false;
        }
      }else if(window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
      else
        return window.close();
    }
    
    // 保存前校验
    function onCheck(e){
      if (e.isValid) {
      	if (isExist(e.value) == true) {
	        e.errorText = "用户名已存在";
	        e.isValid = false;
	     }
	  }
    }
    
    function checkPattern(v){
      var re = new RegExp("^[A-Za-z0-9_]{0,63}$");
      if(re.test(v)) return true;
      return false;
    }
    
    //判断用户是否存在
    function isExist(value){
      var bool;
      if(obj) {
    	 var id_v = obj.data.operatorId;
      }
      $.ajax({
    	url:mini.contextPath + "/user/validateUserId",
        type:'POST',
        data:{value_v: value, id_v: id_v},
        cache:false,
        async:false,
        success:function(text){
          if(mini.consts[text.result]) {
        	  bool = true;
          }
        }
      });
      return bool;
    }

    // 日期比较
    function onCompare(e){
      var startDate = mini.get("startdate").getFormValue();
      var endDate = e.value;
      if(startDate!="")
	    startDate=startDate.substring(0,4) + startDate.substring(5,7) + startDate.substring(8,10);
	  if(endDate!=""){
		endDate=endDate.substring(0,4) + endDate.substring(5,7) + endDate.substring(8,10);
        if(e.isValid){
          if(startDate>endDate){
            e.errorText="截止时间必须大于开始时间";
            e.isValid=false;
          }
        }
      }
    }
    
  </script>
</body>
</html>