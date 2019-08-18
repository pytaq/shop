/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var primarykey=0;  //新增操作,如果>0必定修改
var projectName=''; //得到项目名称
var roleId;        //角色ID

$(function(){
	roleId=$("#roleId").val();  //角色的值

	//得到项目名称
	projectName=$.trim($("body").attr("data-project"));

	$tb=$("#tb");
    $tbDetail=$("#tbDetail");

	//初始化配置信息
    initTable();

   //未添加该角色的用户
    initDetailTable();

    //按钮初始化事件
    initButtonHandler();

});



function initButtonHandler(){


}

function initTable(){

	$tb.bootstrapTable({
		striped:true,   //隐藏变色
		method:"POST",  //请求后台的数据的方式
		url: projectName+"/admin/manage/roleUser/ownuser/"+roleId,         //后台的服务器地址
		sidePagination:"server",              //从后台服务器读取
		contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
		queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
		                         //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc]
		pagination:true,         //要显示分页条
		pageNumber:1,            //当前第1页
		pageSize:10,              //每页显示几笔
		pageList:[5,10, 25, 50, 100],   //每页显示的笔数列表
		clickToSelect:true,               //点击选中一行
		singleSelect:false,               //只能true单选,false多选
        queryParams:function(params){   //自定义查询参数
            return params;
        },
		columns:[
			{radio:true},
			{field:"id",title:"用户编号"},
			{field:"username",title:"用户名"},
			{field:"options",title:"操作",
				formatter: operateOwnFormatter  ,  //格式化显示的内容
		    	events:operateFormatterEvents   //绑定事件
		    }
		]
	});

}
function initDetailTable(){

    $tbDetail.bootstrapTable({
        striped:true,   //隐藏变色
        method:"POST",  //请求后台的数据的方式
        url: projectName+"/admin/manage/roleUser/nouser/"+roleId,         //后台的服务器地址
        sidePagination:"server",              //从后台服务器读取
        contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
        queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
                                 //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
        queryParams:function(params){   //自定义查询参数
            return params;
        },

        pagination:true,         //要显示分页条
        pageNumber:1,            //当前第1页
        pageSize:10,              //每页显示几笔
        pageList:[ 10,20,50, 100,200],   //每页显示的笔数列表
        clickToSelect:true,               //点击选中一行
        singleSelect:false,               //只能true单选,false多选
        selectItemName:"btDetailRadio",              // radio or checkbox 的字段名
        columns:[
            {checkbox:true  },
            {field:"id",title:"用户编号"},
            {field:"username",title:"用户名称"} ,
            {field:"options",title:"操作", name:"detail",
                formatter: operateFormatter  ,  //格式化显示的内容
                events:operateFormatterEvents   //绑定事件
            }
        ]

    });

}

 //拥有用户做删除操作
function operateOwnFormatter(value, row, index){
    return '<button type="button" class="removecls btn  btn-danger"><i class="fa fa-pencil-square-o" ></i>&nbsp;删除</button>';

}

//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index){
	 return '<button type="button" class="addcls btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;添加</button>';

}

//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .removecls': function (e, value, row, index) {
    	console.log("你点击了下标"+index+"的修改按钮");
    	removeInfo(row);
    },
    'click .addcls': function (e, value, row, index) {
        console.log("你点击了下标"+index+"的修改按钮");
        addInfo(row);
    }

};

//移出用户
function removeInfo(row){
    var userId=row.id;
   //简单验证两个值都要存在
    if( !(userId && roleId)){
       return;
	}

	$.ajax({
		type:"GET",
		url:projectName+"/admin/manage/roleUser/remove/roleId/"+roleId+"/userId/"+userId,
		dataType:"json",
		success:function(resp){
			//对话框
            BootstrapDialog.alert({
                title: '提示',
                message: resp.message,
                type: resp.code==0?BootstrapDialog.TYPE_SUCCESS: BootstrapDialog.TYPE_DANGER,
                closable: false, // <-- Default value is false
                draggable: true, // 拖动
                buttonLabel: '确定', // <-- Default value is 'OK',
                callback: function(result) {

                    if(resp.code===0){
                        //刷新
                        $tb.bootstrapTable('refresh',{query:{offset:0}});
                        $tbDetail.bootstrapTable('refresh',{query:{offset:0}});
                    }
                }
            });
		}

	});

}

//添加用户
function addInfo(row){
    var userId=row.id;
    //简单验证两个值都要存在
    if( !(userId && roleId)){
        return;
    }

    $.ajax({
        type:"GET",
        url:projectName+"/admin/manage/roleUser/add/roleId/"+roleId+"/userId/"+userId,
        dataType:"json",
        success:function(resp){
            //对话框
            BootstrapDialog.alert({
                title: '提示',
                message: resp.message,
                type: resp.code==0?BootstrapDialog.TYPE_SUCCESS: BootstrapDialog.TYPE_DANGER,
                closable: false, // <-- Default value is false
                draggable: true, // 拖动
                buttonLabel: '确定', // <-- Default value is 'OK',
                callback: function(result) {

                    if(resp.code===0){
                        //刷新
                        $tb.bootstrapTable('refresh',{query:{offset:0}});
                        $tbDetail.bootstrapTable('refresh',{query:{offset:0}});
                    }
                }
            });
        }

    });
}