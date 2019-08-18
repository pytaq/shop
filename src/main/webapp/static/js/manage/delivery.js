/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var primarykey = 0;  //新增操作,如果>0必定修改 //产品的编号,0代表顶级的
var projectName = ''; //得到项目名称


$(function () {

    $tb = $("#tb");
    //得到项目名称
    projectName = $.trim($("body").attr("data-project"));

    //初始化配置信息
    initTable();

    //按钮初始化事件
    initButtonHandler();

    //表单验证的js(bootstrap-validator.js)
    validatorForm();
});


//表单验证的js(bootstrap-validator.js)
function validatorForm() {

    $('#editForm').bootstrapValidator({
        excluded: [':disabled'],  //排除的样式
        message: '输入的值无效',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok', //验证通过的图标
            invalid: 'glyphicon glyphicon-remove',  //验证失败的图标
            validating: 'glyphicon glyphicon-refresh'  //正在验证中的图标
        },
        fields: {
            //添加验证的表单
            deliveryexplain: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '配送说明不能为空'
                    },
                    stringLength: {
                        min: 2,
                        max: 100,
                        trim: 'trim',
                        message: '名称长度必须在2到100个字符之间'
                    },
                    remote: {
                        type: 'POST',
                        url: projectName + '/admin/manage/delivery/exist',
                        message: '该值已被占用，请重新输入',
                        data:function(){
                            return {
                                id: primarykey
                            };
                        }
                    }
                } //validators验证结束

            },
            deliveryfee: {
                validators: {
                    notEmpty: {
                        message: '配送费不能为空'
                    },
                    greaterThan: {
                        value: 0,
                        message: "最低配送费为0元"
                    },
                    lessThan: {
                        value: 1000,
                        message: "最高配送费为500元"
                    }
                }
            }

        }
    });

}

function initButtonHandler() {

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

function initTable() {

    $tb.bootstrapTable({
        striped:true,   //隐藏变色
        method:"POST",  //请求后台的数据的方式
        url: projectName+"/admin/manage/delivery/search",         //后台的服务器地址
        sidePagination:"server",              //从后台服务器读取
        contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
        queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
                                 //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
        queryParams:function(params){   //自定义查询参数
            params["deliveryexplain"]=$("#search_deliveryexplain").val();
            return params;
        },
        pagination:true,         //要显示分页条
        pageNumber:1,            //当前第1页
        pageSize:5,              //每页显示几笔
        pageList:[5,10, 25, 50, 100],   //每页显示的笔数列表
        clickToSelect:true,               //点击选中一行
        singleSelect:false,
        columns: [
            {
                field: 'id',
                title: '编号',
                align: 'center'
            },
            {
                field: 'deliveryexplain',
                title: '配送说明',
                align: 'center'
            },
            {
                field: 'deliveryfee',
                title: '配送费',
                align: 'center'
            },
            //自定义编辑列
            {
                title: "操作",
                field: 'operate',
                align: 'center',
                formatter: operateFormatter,  //格式化显示的内容
                events: operateFormatterEvents   //绑定事件
            }
        ]

    });
}

//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index) {

        return '<button type="button" class="deliveryedit btn   btn-primary" style="margin-right:15px;"><i class="fa fa-plus" ></i>&nbsp;修改</button>'+
            '<button type="button" class="deliverydel btn   btn-danger" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;删除</button>'

}


//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .deliverydel': function (e, value, row, index) {
        console.log("你点击了下标"+index+"的删除按钮");
        deliverydelrow( row);
    },

    'click .deliveryedit': function (e, value, row, index) {
        console.log("你点击了下标"+index+"的修改按钮");
        deliveryeditrow(row);
    }
};

//显示修改表单
function deliveryeditrow(row){
    //https://v3.bootcss.com/javascript/#modal-show  看这个文档

    primarykey=row.id;  //保存主键
    //还原值
    $("#edit_deliveryexplain").val( row.deliveryexplain);
    $("#edit_deliveryfee").val( row.deliveryfee);

    //重置验证的规则样式，但不清除值
    $('#editForm').data('bootstrapValidator').resetForm(false);


    $("#myModalLabel").text("修改");
    $('#myModal').modal({

        backdrop:'static',
        show:true
    });

}

function  deliverydelrow(row) {
    primarykey=row.id;
    $.ajax({
        type:"POST",
        url:projectName+"/admin/manage/delivery/delete",
        dataType:"json",
        data: "id="+primarykey,
        success:function(resp){
            if(resp.code===0) {
                $tb.bootstrapTable('refresh');
            }
        }

    });
}


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

        var dataStr=$("#editForm").serialize()
        //修改就要协带主键
        if(primarykey>0){
            dataStr+="&id="+primarykey;
        }

        console.log(dataStr);

        //向后台服务器发送ajax请求
        $.ajax({
            type: "POST",
            url:projectName+ "/admin/manage/delivery/save",
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
