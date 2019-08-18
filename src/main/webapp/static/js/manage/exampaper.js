/**
 *  试卷要单独跳转页面
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
 
var projectName=''; //得到项目名称

$(function(){
	//得到项目名称
	projectName=$.trim($("body").attr("data-project"));	
	
	$tb=$("#tb");
	
	//初始化配置信息
    initTable();	
    
    //按钮初始化事件
    initButtonHandler();
  
});

 
function initButtonHandler(){
	
	//查询
	$("#btnSearch").click(function(){
		//刷新
		$tb.bootstrapTable('refresh',{query:{offset:0}});
		
	});
	 
}

function initTable(){
	 
	$tb.bootstrapTable({
		striped:true,   //隐藏变色
		method:"POST",  //请求后台的数据的方式
		url: projectName+"/manage/exampaper/search",         //后台的服务器地址
		sidePagination:"server",              //从后台服务器读取
		contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
		queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
		                         //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
		queryParams:function(params){   //自定义查询参数
			
			params["paperName"]=$("#search_paperName").val();
			params["examType"]=$("#search_examType").val();
			params["status"]=$("#search_status").val();
		 
			console.log(params);
			return params;
		},
		
		pagination:true,         //要显示分页条
		pageNumber:1,            //当前第1页
		pageSize:10,              //每页显示几笔
		pageList:[5,10, 25, 50, 100],   //每页显示的笔数列表	
		clickToSelect:true,               //点击选中一行
		singleSelect:false,               //只能true单选,false多选
		columns:[
			{radio:true},
			{field:"id",title:"试卷编号"},
			{field:"paperName",title:"试卷名称"},
			{field:"questionCount",title:"试题总量"},
			{field:"examType",title:"试卷类型",formatter:examTypeFormatter},
			{field:"status",title:"试卷状态",formatter:statusFormatter}, 
			{field:"updateTime",title:"更新时间"}, 
			{field:"updateUser",title:"更新人"}, 
			{field:"options",title:"操作",
				formatter: operateFormatter  //格式化显示的内容		
		    }
		]     //表格中要显示的列一些属性 
	});                
	
}


//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index){
	var url=projectName+"/manage/exampaper/edit?id="+row.id;
	 return '<a  href="'+url+'" class=" btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</a>';
  
}

//格式化试题类型
function statusFormatter(value, row, index){
	return   (value==1)?"<span class='label label-primary'>已上线</span>" : "<span class='label label-success'>未上线</span>";
}
 
//格式化 单选还是多选
function examTypeFormatter(value, row, index){
	return value==1?"<span class='label label-primary'>正式考试</span>":"<span class='label label-success'>练习试题</span>";
}
 
 
