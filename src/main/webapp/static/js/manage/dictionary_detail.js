/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var $tbDetail;  //详情
var primarykey=0;  //新增操作,如果>0必定修改
var projectName=''; //得到项目名称

var uploader;     //上传的对象
var state = 'pending'; //文件上传状态的文字

$(function(){
	//得到项目名称
	projectName=$.trim($("body").attr("data-project"));	
	
	$tb=$("#tb");
	$tbDetail=$("#tbDetail");
	
	
	//初始化配置信息
    initTable();	
    
    
     //初始化文件上传对象
    initWebUpload();
    
    
    //按钮初始化事件
    initButtonHandler();
  
   
    
});

//初始化文件上传对象
function initWebUpload(){	
	
	uploader = WebUploader.create({
	    // swf文件路径
	    swf: projectName + '/statis/js/plugins/webuploader/Uploader.swf',
	    // 文件接收服务端。
	    server: projectName+'/manage/dictionary/excel',
	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#picker',
	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false,
	    accept:{
	    	title: 'Excel',
	 	    //文件的手缀
	 	    extensions: 'xlsx',
	 	    //不允许多文件上传
	 	    mimeTypes: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
	    },	 
	    fileNumLimit: 1, //限制上传个数
	    fileSingleSizeLimit: 2048000 //限制单个上传图片的大小
	});
	
	
	let $list=$("#thelist");
	//监听当文件被添加的时候
	uploader.on( 'fileQueued', function( file ) {
	    $list.append( '<div id="' + file.id + '" class="item">' +
	        '<h4 class="info">' + file.name + '</h4>' +
	        '<p class="state">等待上传...</p>' +
	    '</div>' );
	});
	
	// 文件上传过程中创建进度条实时显示。
	uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress .progress-bar');

	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<div class="progress progress-striped active">' +
	          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
	          '</div>' +
	        '</div>').appendTo( $li ).find('.progress-bar');
	    }

	    $li.find('p.state').text('上传中');

	    $percent.css( 'width', percentage * 100 + '%' );
	});
	
	//上传成功监听(回调)
	uploader.on( 'uploadSuccess', function( file,response ) {
	    $( '#'+file.id ).find('p.state').text('已上传');
	    console.log("----uploadSuccess----");
	    console.log(response);
	    
	    let typeStyle=response.code==0?"type-primary":"type-warning";
	    //显示消息框
	    BootstrapDialog.show({
            title: '提示',
            message: response.message,
            draggable: true,
            type:typeStyle
        }); 
	    
	    if(response.code==0){	    	 
	    	 closeUploader();
	    	 //隐藏上传对话框
	    	 $('#myModalExcel').modal('hide');	    	 
	    }
	  
	});

	//上传失败监听(回调)
	uploader.on( 'uploadError', function( file ) {
	    $( '#'+file.id ).find('p.state').text('上传出错');
	});

	//上传完成(回调)
	uploader.on( 'uploadComplete', function( file,response ) {
	    $( '#'+file.id ).find('.progress').fadeOut();
	   
	    
	}); 
	
	//开始上传按钮
	var $ctlBtn=$("#ctlBtn");
	uploader.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state = 'done';
        }
         
        if ( state === 'uploading' ) {
        	$ctlBtn.text('暂停上传');
        } else {
        	$ctlBtn.text('开始上传');
        }
    });
	
	
	$ctlBtn.on( 'click', function() {
		//上传中
        if ( state === 'uploading' ) {
            uploader.stop();   //状态停止
        } else {
            uploader.upload();  //继续上传
        }
    });
}
   
/*关闭上传框窗口后恢复上传框初始状态*/
function closeUploader() {        
        // 移除所有缩略图并将上传文件移出上传序列
        for (var i = 0; i < uploader.getFiles().length; i++) {
            // 将图片从上传序列移除
            uploader.removeFile(uploader.getFiles()[i]); 
            // 将图片从缩略图容器移除
            var $li = $('#' + uploader.getFiles()[i].id);
            $li.off().remove();
        } 
        // 重置uploader，目前只重置了文件队列
        uploader.reset(); 
        
    }



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
	        	discName:{
	        		 message: '输入的值无效',
	        		 validators:{
	        			 notEmpty: {
	                         message: '名称不能为空'
	                     },
	                     stringLength: {
	                         min:1,
	                         max: 30,
	                         trim: 'trim',
	                         message: '名称长度必须在1到30个字符之间'
	                     }, 
	                     remote: {
	                         type: 'POST',
	                         url: projectName+'/manage/dictionary/exist',
	                         message: '该值已被占用，请重新输入',
	                         data:function(){
	                        	 return {
	                        		 id: primarykey
	                        	 };
	                         }
	                     }
	        		 } //validators验证结束
	        
	        	}, //roleName结束
	        	 
	        
	        }
	    });
	 
}

function initButtonHandler(){
		
	//保存按钮
	$("#btnSave").click(saveFormData);
	//新增按钮
	$("#btnAdd").click(addFormData);
	
	//上传按钮
	$("#btnUpload").click(uploadExcelFunc);
}

function initTable(){
	 
	$tb.bootstrapTable({
		striped:true,   //隐藏变色
		method:"POST",  //请求后台的数据的方式
		url: projectName+"/manage/dictionary/search",         //后台的服务器地址
		sidePagination:"server",              //从后台服务器读取
		contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
		queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
		                         //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
		queryParams:function(params){   //自定义查询参数			 
			return params;
		},
		
		pagination:true,         //要显示分页条
		pageNumber:1,            //当前第1页
		pageSize:100,              //每页显示几笔
		pageList:[ 50, 100,200],   //每页显示的笔数列表	
		clickToSelect:true,               //点击选中一行
		singleSelect:false,               //只能true单选,false多选
		columns:[ 
			{radio:true},
			{field:"id",title:"编号"},
			{field:"discName",title:"字典名称"} 
		] ,
		onClickRow:function(row, $element){
			console.log(row);
			primarykey=row.id; //数据字典的主键
			
			//销毁表格，再重新创建			
			 $tbDetail.bootstrapTable("destroy");
			
			initDetailTable();
		}
	});                
	
}

//根据选中的数据字典，来显示相应的数据详情
function initDetailTable(){
	 
	$tbDetail.bootstrapTable({
		striped:true,   //隐藏变色
		method:"POST",  //请求后台的数据的方式
		url: projectName+"/manage/dictionary_detail/search",         //后台的服务器地址
		sidePagination:"server",              //从后台服务器读取
		contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
		queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
		                         //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
		queryParams:function(params){   //自定义查询参数	
			params["dictionaryId"]=primarykey;
			return params;
		},
		
		pagination:true,         //要显示分页条
		pageNumber:1,            //当前第1页
		pageSize:100,              //每页显示几笔
		pageList:[ 50, 100,200],   //每页显示的笔数列表	
		clickToSelect:true,               //点击选中一行
		singleSelect:false,               //只能true单选,false多选
		selectItemName:"btDetailRadio",              // radio or checkbox 的字段名
		columns:[ 
			{radio:true  },
			{field:"id",title:"编号"},
			{field:"detailName",title:"字典名称"} ,
			{field:"options",title:"操作", name:"detail",
				formatter: operateFormatter  ,  //格式化显示的内容			
		    	events:operateFormatterEvents   //绑定事件
		    }
		]  
		 
	});                
	
}


 

//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index){
	 return '<button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>';
  
}

//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .compnayOfedit': function (e, value, row, index) { 
    	editForm(row);
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
	$("#edit_roleName").val( row.roleName);
	$("#edit_authority").val( row.authority);
	
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
	 setTimeout(() => {
		 
		var result=bsv.isValid();
		console.log("saveFormData:"+result);
		 //验证不成功
		 if(!result){
			 return;
		 } 
		 
		 var dataStr=$("#editForm").serialize()
			//修改就要协带主键
			if(primarykey>0){
				dataStr+="&id="+primarykey;
			}
		 
			console.log(dataStr);
		   
			//向后台服务器发送ajax请求
			$.ajax({
				   type: "POST",
				   url:projectName+ "/manage/dictionary/save",
				   //向后台发送的数据
				   data: dataStr,
				   //返回json格式
				   dataType:"json",   
				   success: function(resp){
				      //{"code":0,"message:"添加数据成功"}
					   if(resp.code===0){
						   //隐藏模态框
						   $('#myModal').modal('hide');
						    //重新加载数据
							$tb.bootstrapTable('refresh');
						   
					   }else{
						   //提示错误
						   alert(resp.message);
					   }
				   }
				});
		  
	 },100); 
	  
}
 


//打开excel上传模态框
function uploadExcelFunc(){
	 closeUploader();
	$('#myModalExcel').modal({ 
		 backdrop:'static',
		 show:true
	 });
}


