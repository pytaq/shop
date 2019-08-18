/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var primarykey=0;  //新增操作,如果>0必定修改
var projectName=''; //得到项目名称

$(function(){
	//得到项目名称
	projectName=$.trim($("body").attr("data-project"));	
	
	$tb=$("#tb");
	
	//初始化配置信息
    initTable();	
    
    //按钮初始化事件
    initButtonHandler();
    
    //表单验证的js(bootstrap-validator.js)
    validatorForm();
});

//表单验证的js(bootstrap-validator.js)
function validatorForm(){
	$('#editForm').bootstrapValidator({
		   excluded: [':disabled'],  //排除的样式
	 	   message: '输入的值无效',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok', //验证通过的图标
	            invalid: 'glyphicon glyphicon-remove',  //验证失败的图标
 	            validating: 'glyphicon glyphicon-refresh'  //正在验证中的图标
	        },
	        fields: {   
	            //添加验证的表单的name	        	 
	        	rolename:{
	        		 message: '输入的值无效',
	        		 validators:{
	        			 notEmpty: {
	                         message: '名称不能为空'
	                     },
	                     stringLength: {
	                         min: 2,
	                         max: 30,
	                         trim: 'trim',
	                         message: '名称长度必须在2到30个字符之间'
	                     },
	                     remote: {
	                         type: 'POST',
	                         url: projectName+'/admin/manage/sysRole/exist',
	                         message: '该值已被占用，请重新输入',
	                         data:function(){
	                        	 return {
	                        		 id: primarykey
	                        	 };
	                         }
	                     }
	        		 } //validators验证结束
	        
	        	}, //rolename结束
	        	authority:{
	        		 message: '输入的值无效',
	        		 validators:{
	        			 notEmpty: {
	                         message: '标识不能为空'
	                     },
	                     stringLength: {
	                         min: 1,
	                         max: 20,
	                         trim: 'trim',
	                         message: '标识长度必须在1到20个字符之间'
	                     },
	                     remote: {
	                         type: 'POST',
	                         url: projectName+'/admin/manage/sysRole/exist',
	                         message: '该值已被占用，请重新输入',
	                         data:function(){
	                        	 return {
	                        		 id: primarykey
	                        	 };
	                         }
	                     },
	        		 } //validators验证结束
	        
	        	} //authority结束
	        
	        }
	    });
	 
}

function initButtonHandler(){
	
	//查询
	$("#btnSearch").click(function(){
		//刷新
		$tb.bootstrapTable('refresh',{query:{offset:0}});
		
	});
	
	//保存按钮
	$("#btnSave").click(saveFormData);
	//新增按钮
	$("#btnAdd").click(addFormData);
}

function initTable(){
	 
	$tb.bootstrapTable({
		striped:true,   //隐藏变色
		method:"POST",  //请求后台的数据的方式
		url: projectName+"/admin/manage/sysRole/search",         //后台的服务器地址
		sidePagination:"server",              //从后台服务器读取
		contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
		queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
		                         //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
		queryParams:function(params){   //自定义查询参数
			params["rolename"]=$("#search_rolename").val();
			params["authority"]=$("#search_authority").val();
			console.log(params);
			return params;
		},
		
		pagination:true,         //要显示分页条
		pageNumber:1,            //当前第1页
		pageSize:2,              //每页显示几笔
		pageList:[2,5,10, 25, 50, 100],   //每页显示的笔数列表	
		clickToSelect:true,               //点击选中一行
		singleSelect:false,               //只能true单选,false多选
		columns:[
			{radio:true},
			{field:"id",title:"角色编号"},
			{field:"rolename",title:"角色名称"},
			{field:"authority",title:"角色标识"},
			{field:"state", title:"角色状态",
			formatter: function (value, row) {
                    if (value == 1) {
                        return "启用";
                    } else {
                        return "禁用";
                    }
                }
			},
			{field:"options",title:"操作",
				formatter: operateFormatter  ,  //格式化显示的内容			
		    	events:operateFormatterEvents   //绑定事件
		    }
		]     //表格中要显示的列一些属性 
	});                
	
}


//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index){

	 return '<button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>' +
        ' <button type="button" class="autoUser btn  btn-success"><i class="fa fa-pencil-square-o" ></i>&nbsp;分配用户</button>'+
         ' <button type="button" class="autoMenu btn  btn-info"><i class="fa fa-pencil-square-o" ></i>&nbsp;分配菜单权限</button>';
  
}

//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .compnayOfedit': function (e, value, row, index) {
    	console.log("你点击了下标"+index+"的修改按钮"); 
    	editForm(row);
    } ,
    'click .autoUser': function (e, value, row, index) {
        window.location.href=projectName+"/admin/manage/roleUser/"+row.id;
    },
    'click .autoMenu': function (e, value, row, index) {
        window.location.href=projectName+"/admin/manage/menu/authority/roleId/"+row.id;
    }

};

//显示新增表单
function addFormData(){
	primarykey=0;  //主键必须为0

    $("#myModalLabel").text("新增");
    $('#myModal').modal({
		 
		 backdrop:'static',
		 show:true
	 });
    
     // 清空值
    resetFormValue("#editForm input");
     
  //重置验证的规则样式，要清除值
   $('#editForm').data('bootstrapValidator').resetForm(true);
}

//显示修改表单
function editForm(row){
	//https://v3.bootcss.com/javascript/#modal-show  看这个文档
	 	
	primarykey=row.id;  //保存主键	
	//还原值
	$("#edit_rolename").val( row.rolename);
	$("#edit_authority").val( row.authority);
    $("#edit_state").val( row.state);

	//重置验证的规则样式，但不清除值
	 $('#editForm').data('bootstrapValidator').resetForm(false);
	 
	
    $("#myModalLabel").text("修改");
	$('#myModal').modal({
		 
		 backdrop:'static',
		 show:true
	 });

}

//新增 或 修改  保存 表单的数据
function saveFormData(){	
 
	//手动调用，验证表单是否通过了
	var bsv = $('#editForm').data('bootstrapValidator');
	//手动调用
	 bsv.validate();
	
	//异步 ajax(remote)效验需要有一个延迟处理的时间
	 setTimeout(function(){
		var result=bsv.isValid();
		console.log("saveFormData:"+result);
		 //验证不成功
		 if(!result){
			 return;
		 } 
		 //表单序列化
		 var dataStr=$("#editForm").serialize()
			//修改就要协带主键
			if(primarykey>0){
				dataStr+="&id="+primarykey;
			}
		 
			console.log(dataStr);
		   
			//向后台服务器发送ajax请求
			$.ajax({
				   type: "POST",
				   url:projectName+ "/admin/manage/sysRole/save",
				   //向后台发送的数据
				   data: dataStr,
				   //返回json格式
				   dataType:"json",   
				   success: function(resp){
                       console.log(resp);
				      //{"code":0,"message:"添加数据成功"}
					   if(resp.code===0){
						   //隐藏模态框
						   $('#myModal').modal('hide');

                           BootstrapDialog.show({
                               title: '提示',
                               message: resp.message,
                               draggable: true,
                               type:"type-success"
                           });
						    //重新加载数据
							$tb.bootstrapTable('refresh');
						   
					   }else{
						   //提示错误
                           BootstrapDialog.show({
                               title: '提示',
                               message: resp.message,
                               draggable: true,
                               type:"type-success"
                           });
					   }
				   }
				});
		  
	 },100);
	 
	  
}
