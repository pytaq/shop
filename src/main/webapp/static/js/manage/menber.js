var tb ;//全局变量
var projectName = ''; // 得到项目名称
var primarykey = 0; // 新增操作,如果>0必定修改
//初始化
$(function () {
    $tb = $("#tb");//显示表格
    projectName = $.trim($("body").attr("data-project"));

    // 配置初始化
    initTable();
    // 按钮初始化事件
    initButtonHandler();


})
//初始化配置
function initTable() {

    $tb.bootstrapTable({
        method: "POST",// 请求后台的数据方式
        url: projectName + "/admin/manage/member/sreach",// 后台服务器地址
        sidePagination: "server",// 从后台服务器读取
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",// 提交数据查询参数的格式
        queryParamsType: "limit", // 分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
        // 分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，sortName[排序列]，sortOrder[排序的方式 asc/desc])
        queryParams: function (params) { // 自定义查询参数
            params["email"] = $("#search_email").val();
            params["rolename"] = $("#search_realname").val();
            params["mobile"] = $("#search_mobile").val();
            console.log(params);
            return params;
        },
        pagination: true, // 要显示分页条
        pageNumber: 1, // 当前第1页
        pageSize: 2, // 每页显示几笔
        pageList: [2, 5, 10, 25, 50, 100], // 每页显示的笔数列表
        clickToSelect: true, // 点击选中一行
        singleSelect: false, // 只能true单选,false多选
        columns: [
            {radio: true},
            {field: "realname", title: "真实姓名"},
            {field: "mobil", title: "电话号码"},
            {field: "email", title: "email"},
            {field: "credit", title: "积分"},
            {field: "gold", title: "余额"},
            {field: "istemplate", title: "临时账号", formatter:templateType},
            {field: "status", title: "状态", formatter:statusType },
            {
                field : "options",
                title : "操作",
                formatter : operateFormatter, // 格式化显示的内容
                events : operateFormatterEvents
                // 绑定事件
            }
        ]

    })
}

// 自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index) {

    return '<button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;详情</button>';
}



// 初始化操作按钮的方法
window.operateFormatterEvents = {
    "click .compnayOfedit": function (e, value, row, index) {
        console.log("你点击了下标" + index + "的修改按钮");
        editForm(row);
        console.log(row);

    }
};

//弹出修改模态框
function editForm(row) {
    // 设置primarykey,保存主键
    primarykey = row.openid;
    // 给模态框赋值
    $("#edit_email").html(row.email);
    $("#edit_realname").html(row.realname);
    $("#edit_mobile").html(row.mobile);
    $("#edit_istemplate").html(row.istemplate==0?"是":"否");
    $("#edit_status").html(row.status==0?"禁用":"启用");

    $("#edit_credit").html(row.credit);
    $("#edit_experience").html(row.experience);
    $("#edit_gold").html(row.gold);

    //微信是否显示
    var showWx=row.weixinOpenid;
    if(showWx){
        $("#weixinInfo").show();
        $("#edit_avatar").attr("src",row.wxfans.avatar);
        var gender=row.wxfans.gender || -1;
        if(gender==-1){
            $("#edit_gender").html("无法获取微信值");
        }else{
            $("#edit_gender").html(gender==1?"男":"女");
        }

    }else{
        $("#weixinInfo").hide();
        $("#edit_avatar").attr("src","#");
        $("#edit_gender").html("");
    }



        //weixinInfo

    // 动态修改模态框标题
    $("#myModalLabel").text("详情");
    // 设置模态框
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });

}


// 按钮初始化事件
function initButtonHandler() {
    //查询按钮,刷新，并且把显示第一页
    $("#btnSearch").click(function () {
        $tb.bootstrapTable('refresh', {
            query: {
                offset: 0
            }
        })
    })


};



//判断是否为临时账号
function templateType(vaule,row ) {
    var str = '';
    if(row.istemplate ===0){
        return str+= '<label class="btn btn-danger" onclick="changeTemplate(\''+row.openid+'\',1)" >否</label>';
    }else {
        return str +='<label  class="btn btn-primary" onclick="changeTemplate(\''+row.openid+'\',0)">是</label>';

    }

}
//判断账号状态
function statusType(vaule,row) {
    var str = '';
    if(row.status ===0){
        return str +='<label class="btn btn-danger" onclick="changeState(\''+row.openid+'\',1)" >  禁用</label>';

    }
    else{
        return str +='<label class="btn btn-primary" onclick="changeState(\''+row.openid+'\',0)" > 可用</label>';
    }
}

//是否为监听账户
function changeTemplate(openid,state){
    //询问对话框
    console.log(openid+","+state);
}

//账户禁用或启用
function changeState(openid,state){
    //询问对话框
}

