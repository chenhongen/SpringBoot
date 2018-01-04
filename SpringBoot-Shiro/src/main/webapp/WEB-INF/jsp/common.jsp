<%
	String contextPath = request.getContextPath();
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="<%=contextPath%>/open/jquery.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/open/miniui/miniui.js"></script>
<script>
	(function(){
		mini.contextPath = '<%=contextPath %>';
		
		mini.consts = {"SUCCESS": true, "FAIL": false};
		/* mini.getDictText = function(dictTypeId, dictId){
			var result = null;
			if(dictTypeId == null || dictTypeId == "" || dictId == null || dictId == "")
				return result;
			$.ajax({
				url : mini.contextPath + '/dict/getDictText',
				type : 'POST',
				data: {dictTypeId: dictTypeId, dictId:dictId},
				cache : false,
				async : false,
				success : function(data) {
					result = data;
				}
			});
			
			return result;
		} */
		// --begin 数据字典扩展 基于nui修改 add by che
		(function(){
			mini.DictCheckboxGroup = function () {
	            mini.DictCheckboxGroup.superclass.constructor.call(this)
	        };
	        mini.DictRadioGroup = function () {
	            mini.DictRadioGroup.superclass.constructor.call(this)
	        };
			mini.DictComboBox=function(){
				mini.DictComboBox.superclass.constructor.call(this);
			};
			var a={
				map:{},
				loadingMap:{},
				removeEmpty:function(e){
					for (var d = 0, c = e.length; d < c; d++) {
	                    if (e[d] && e[d].__NullItem) {
	                        e.splice(d, 1)
	                    }
	                }
				},
				getDictName:function(all,ids){
					var array=[];

					for(var a=0,c=all.length;a<c;a++){
						var entry=all[a];

						//if(nui.fn.contains(ids,entry.dictID)){
						if(ids === entry.dictid){ // 1, 11?
							array.push(entry.dictname);
						}
					}
					return array.join(",");
				},
				ajaxLoad:function(d){
					var c={dictTypeId:d.dictTypeId};
					mini.ajax({
						url:mini.contextPath + "/dict/getDictType",
						data:c,
						type:"POST",
						async:false,
						success:function(f){
							var e=JSON.parse(f);
							a.map[dictTypeId]=e;
							d._setDictData(e);
						}
					});
				},
				getDictText:function(c,e){
					if(e == null) return;
					var d=a.map[c];

					if(d != null){
						return a.getDictName(d,e);
					}
					var f="";
					mini.ajax({
						url:mini.contextPath + "/dict/getDictType",
						data:{dictTypeId:c},type:"POST",async:false,
						success:function(g){
							a.map[c]=JSON.parse(g);
							f=a.getDictName(JSON.parse(g),e);
						}
					});
					return f;
				},
				loadData:function(){
					var c=this.dictTypeId;
					if(!c){
						return;
					}
					var d=a.map[c];
					if(!d){
						mini.ajax({
							url: mini.contextPath + "/dict/getDictType",//自定义逻辑流
							data:{dictTypeId:c},
							type:"POST",
							async:false,
							success:function(f){
								var e=JSON.parse(f)
								//findObjectAttribute(e[0])
								//a.removeNotValid(e);
								a.map[c]=e;
							}
						});
						d=a.map[c];
					}
					//a.addEmpty(d);
					a.removeEmpty(d);
					this._setDictData(d);
				}/* ,
				addEmpty:function(e){
					if(e.length>0 && e[0].dictID != ""){
						e.unshift({dictName:"",dictID:""});
					}
				},
				removeNotValid:function(e){
					for(var d=0,c=e.length;d<c;d++){if(e[d]&&e[d].status!=1){e.splice(d,1);}}
				} */
			};
			mini.getDictText=a.getDictText;
			var b={
				dictTypeId:"",
				textField:"dictname",
				valueField:"dictid",
				_initData:function(){
					a.loadData.call(this);
				},
				_setDictData:function(c){
					this.loadData(c);
					if(this.value){
						this.setValue(this.value);
					}
				}
			};
			b.uiCls = "mini-dictcheckboxgroup";
	        jQuery.extend(b, {
	            uiCls: "mini-dictcheckboxgroup",
	            set: function (c) {
	                mini.DictCheckboxGroup.superclass.set.call(this, c);
	                this._initData()
	            },
	            getAttrs: function (d) {
	                var c = mini.DictCheckboxGroup.superclass.getAttrs.call(this, d);
	                var e = jQuery(d);
	                mini._ParseString(d, c, ["dictTypeId"]);
	                return c
	            }
	        });
	        mini.extend(mini.DictCheckboxGroup, mini.CheckBoxList, b);
	        jQuery.extend(b, {
	            uiCls: "mini-dictradiogroup",
	            set: function (c) {
	                mini.DictRadioGroup.superclass.set.call(this, c);
	                this._initData()
	            },
	            getAttrs: function (d) {
	                var c = mini.DictRadioGroup.superclass.getAttrs.call(this, d);
	                var e = jQuery(d);
	                mini._ParseString(d, c, ["dictTypeId"]);
	                return c
	            }
	        });
	        mini.extend(mini.DictRadioGroup, mini.RadioButtonList, b);
	        jQuery.extend(b,{
				uiCls:"mini-dictcombobox",
				_afterApply:function(c){
					mini.DictComboBox.superclass._afterApply.call(this,c);
					this._initData();
				},
				getAttrs:function(d){
					var c=mini.DictComboBox.superclass.getAttrs.call(this,d);
					var e=jQuery(d);mini._ParseString(d,c,["dictTypeId"]);
					return c
				},
				_setDictData:function(d){
					this.setValueField(this.valueField);
					this.setTextField(this.textField);
					this.setData(d);
					if(this.value){
						var c=this.value;
						this.value="";
						this.setValue(c)
					}
				}
			});
	        
			mini.extend(mini.DictComboBox,mini.ComboBox,b);
			mini.regClass(mini.DictCheckboxGroup, "dictcheckboxgroup");
	        mini.regClass(mini.DictRadioGroup, "dictradiogroup");
			mini.regClass(mini.DictComboBox,"dictcombobox");
			
		})(mini);
		// --end
	})();
	
	// mini调试模式
	mini_debugger = false;
	
	var data={};
	mini.DataTree.prototype.dataField='data';
	
	// 全局ajax，登陆过期 ajax请求返回主页
	$(document).ajaxComplete(function(event,xhr,options){
		if(xhr.responseText != null && xhr.responseText.indexOf("<!--login_page_identity-->") > -1){
            window.location.href = mini.contextPath+"/";
        }
	});
	
	
	//输出对象键值对
	function po(obj){
		var temp = "";
		for(var i in obj){//用javascript的for/in循环遍历对象的属性
	    	temp += i+":"+obj[i]+"\n";
		}
		console.log(temp);
	}
	
	//无效值判断
	function isEmpty(value) {
		var flag = false;
		if(value == 'null' || value == null || value == "" || typeof(value) == "undefined" ) {
			flag = true;
		}
		
		return flag;
	}
	
	function c(o) {
		console.log(o);
	}
</script>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/open/miniui/themes/default/miniui.css"/>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/icons/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/open/miniui/themes/icons.css"/>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/open/auth.css">
