
var projectName = ''; // 得到项目名称
var primarykey = 0; // 新增操作,如果>0必定修改
//初始化
$(function () {
    $tb = $("#tb");
    projectName = $.trim($("body").attr("data-project"));

    // 配置初始化
    initTable();
    // 按钮初始化事件
    //表单验证
    initButtonHandler();
    validatorForm();
})

function initTable() {
    $tb.bootstrapTable({
        method : "POST",// 请求后台的数据方式
        url : projectName + "/admin/manage/rank/search",// 后台服务器地址
        sidePagination : "server",// 从后台服务器读取
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",// 提交数据查询参数的格式
        queryParamsType : "limit", // 分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
        // 分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，sortName[排序列]，sortOrder[排序的方式 asc/desc])
        queryParams : function(params) { // 自定义查询参数
            params["rankname"] = $("#search_rankname").val();
            console.log(params);
            return params;
        },
        pagination : true, // 要显示分页条
        pageNumber : 1, // 当前第1页
        pageSize : 2, // 每页显示几笔
        pageList : [ 2, 5, 10, 25, 50, 100 ], // 每页显示的笔数列表
        clickToSelect : true, // 点击选中一行
        singleSelect : false, // 只能true单选,false多选
        columns : [ {
            radio : true
        },{
            field : "rankLevel",
            title : "编号"
        }, {
            field : "rankName",
            title : "会员等级名称"
        },{
            field : "experience",
            title : "所需经验值"
        }, {
            field : "options",
            title : "操作",
            formatter : operateFormatter, // 格式化显示的内容
            events : operateFormatterEvents
            // 绑定事件
        } ]

    })
}

// 自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index) {
    return '<button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button> <button type="button" class="compnayOfdelete btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;删除</button>';
}
// 初始化操作按钮的方法
window.operateFormatterEvents = {
    "click .compnayOfedit" : function(e, value, row, index) {
        console.log("你点击了下标" + index + "的修改按钮");
        editForm(row);
        console.log(row);
    }
};

window.operateFormatterEvents={
    "click .compnayOfdelete" : function (e,value,row,index) {
        console.log("你点击了下标"+ index + "的按钮");
        editForm(row);
        console.log(row);
    }
};

//弹出修改模态框
function editForm(row){
    // 设置primarykey
    primarykey = row.id;
    // 给模态框赋值
    $("#edit_rankname").val(row.rankname);
    $("#edit_ranklevel").val(row.ranklevel);
    //重置验证的规则样式，但不清除值
    $('#editForm').data('bootstrapValidator').resetForm(false);
    // 动态修改模态框标题
    $("#myModalLabel").text("修改");
    // 设置模态框
    $('#myModal').modal({
        backdrop : 'static',
        show : true
    });

}


// 按钮初始化事件
function initButtonHandler(){
    //查询按钮,刷新，并且把显示第一页
    $("#btnSearch").click(function () {
        $tb.bootstrapTable('refresh',{
            query:{
                offset : 0
            }
        })
    })
    // 保存按钮
    $("#btnSave").click(saveFormData);
    // 新增按钮
    $("#btnAdd").click(addFormData);
};

function validatorForm(){

    $('#editForm').bootstrapValidator({
        excluded: [':disabled'],//排除其他样式
        message: '输入的值无效',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok', //验证通过的图标
            invalid: 'glyphicon glyphicon-remove',  //验证失败的图标
            validating: 'glyphicon glyphicon-refresh'  //正在验证中的图标
        },
        fields: {
            //添加验证的表单的name
            rankname:{
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
                        message:'该值已被占用，请重新输入',
                        type: 'POST',
                        url: projectName + "/admin/manage/rank/exist",
                        data:function(){
                            return {
                                id: primarykey
                            };
                        }
                    }
                } //validators验证结束

            }, //rankname结束
            password:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {
                        min: 2,
                        max: 30,
                        trim: 'trim',
                        message: '名称长度必须在2到30个字符之间'
                    }
                } //validators验证结束

            } //password结束

        }
    });
};
// 显示新增表单
function addFormData() {
    primarykey = 0; // 主键必须为0
    $("#myModalLabel").text("新增");
    $('#myModal').modal({
        backdrop : 'static',
        show : true
    });

    // 清空值
    resetFormValue("#editForm input");

    //重置验证的规则样式，要清除值
    $('#editForm').data('bootstrapValidator').resetForm(true);
}
// 点击保存触发事件
function saveFormData() {
    //点击保存手动调用验证
    var bsv = $('#editForm').data('bootstrapValidator');
    //手动调用
    bsv.validate();

    //异步 ajax(remote)效验需要有一个延迟处理的时间
    setTimeout(function () {

        //验证不成功
        if(!bsv.isValid()){
            return;
        }
        // 将表单数据转换为键=值&键=值字符串
        var dataStr = $("#editForm").serialize();
        console.log(primarykey);
        // 拼接上id
        if (primarykey > 0) {
            dataStr += "&id=" + primarykey;
        }
        console.log(dataStr);
        // ajax传送数据到服务端
        $.ajax({
            type : "POST",
            url : projectName + "/admin/manage/rank/save",
            data : dataStr,
            dataType : "json",
            success : function(result) {
                // result ={"code":0,"message:"添加数据成功"}
                if (result.code === 0) {
                    // 隐藏模态框
                    $('#myModal').modal('hide');
                    // 重新加载数据
                    $tb.bootstrapTable('refresh');

                } else {
                    // 提示错误
                    alert(result.message);
                }
            }
        });
    },100);
}