

//全局变量
var $tb;
var primarykey = 0;  //新增操作,如果>0必定修改
var projectName = ''; //得到项目名称
var pId = 0;     //支付的编号,0代表顶级的


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
            //添加验证的表单的name
            name: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '名称不能为空'
                    },
                    stringLength: {
                        min: 2,
                        max: 100,
                        trim: 'trim',
                        message: '名称长度必须在2到100个字符之间'
                    },
                    remote: {
                        type: 'POST',
                        url: projectName + '/admin/manage/category/exist',
                        message: '该值已被占用，请重新输入',
                        data: function () {
                            return {
                                id: primarykey
                            };
                        }
                    }
                } //validators验证结束

            },
            commission: {
                validators: {
                    notEmpty: {
                        message: '佣金不能为空'
                    },
                    greaterThan: {
                        value: 0,
                        message:"最小提成为0元"
                    },
                    lessThan: {
                        value: 1000,
                        message:"最大的提成为1000元"
                    }
                }
            }

        }
    });

}


function initButtonHandler() {
    //保存按钮
    $("#btnSave").click(saveFormData);

    //新增顶级按钮
    $("#btnAdd").click(newParentcategory);

    //2上传图片按钮
    KindEditor.ready(function(K) {

        var editor = K.editor({
            allowFileManager : false,
            uploadJson : projectName+'/admin/file/upload',
        });

        //分类图片
        K('#btnChooseImage').click(function() {
            editor.loadPlugin('image', function() {


                editor.plugin.imageDialog({
                    imageUrl : K('#edit_thumb').val(),
                    showRemote : false,
                    clickFn : function(url, title, width, height, border, align) {
                        K('#edit_thumb').val(url);
                        K('#thumbImg').attr("src",url);
                        editor.hideDialog();
                    }
                });
            });
        });

        //分类广告图（可选）
        K('#btnChoosethumbadvImage').click(function() {
            editor.loadPlugin('image', function() {
                editor.plugin.imageDialog({
                    imageUrl : K('#edit_thumbadv').val(),
                    showRemote : false,
                    clickFn : function(url, title, width, height, border, align) {
                        K('#edit_thumbadv').val(url);
                        K('#thumbadvImg').attr("src",url);
                        editor.hideDialog();
                    }
                });
            });
        });

    });



}

function initTable() {

    var projectName = $.trim($("body").attr("data-project"));

    $tb.bootstrapTable({
        method: "POST",  //请求后台的数据的方式
        url: projectName + "/admin/manage/paylog/search",         //后台的服务器地址
        sidePagination: "server",              //从后台服务器读取
        contentType: "application/x-www-form-urlencoded",        //提交数据查询参数的格式
        striped: true,
        idField: 'id',       //主键json的列名
        showColumns: true,
        columns: [

            {
                field: 'id',
                title: '编号',
                align: 'center'
            },

            {
                field: 'paytype',
                title: '支付方式',
                align: 'center'
            },
            {
                field: 'paymaney',
                title: '支付最大金额',
                align: 'center',
                //formatter: imgFormatter //格式化显示的内容
            },
            {
                field: 'ptype',
                title: '支付类型',
                align: 'center',
                //formatter: thumbadvFormatter //格式化显示的内容
            },
            {
                field: 'typename',
                title: '支付名称',
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
        ],
        treeShowField: 'paytype',    //显示json字段名称
        parentIdField: 'pId',        //json上级关联字段
        //重置树形节点视图
        onResetView: function (data) {
            $tb.treegrid({
                initialState: 'expanded',//收缩collapsed,展开expanded
                treeColumn: 0,//指明第几列数据改为树形
                expanderExpandedClass: 'glyphicon glyphicon-triangle-bottom',
                expanderCollapsedClass: 'glyphicon glyphicon-triangle-right',
                onChange: function () {
                    $tb.bootstrapTable('resetWidth');
                }
            });
        }//重置树形节点视图

    });
}

//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index) {
    if (row._level < 2) {
        return [
            '<button type="button" class="categoryOfAddChild btn   btn-primary" style="margin-right:15px;"><i class="fa fa-plus" ></i>&nbsp;新增支付名称</button>',
            '<button type="button" class="categoryOfedit btn   btn-warning" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>'
        ].join('');
    } else {

        return '<button type="button" class="categoryOfedit btn   btn-warning" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>';

    }

}

function IcomFormatter(value){
    if(value==1){
        return '<img src='+projectName+'"/static/img/tuijian.png"  width="50" />';
    }
}

//广告图
function thumbadvFormatter(value,row,index){
    if(value){
        return '<a href="'+row.thumbadvurl+'" target="_blank"><img src="'+value+'"  width="50"/></a>';
    }else{
        return "";
    }
}

//分产品图
function imgFormatter(value,row,index){
    if(value){
        return '<img src="'+value+'"  width="150"/>';
    }else{
        return "";
    }
}
//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .categoryOfedit': function (e, value, row, index) {

        editcategory(row);
    },

    'click .categoryOfAddChild': function (e, value, row, index) {
        addChildcategory(row);
    }
};

//修改的function
function editcategory(row) {
    console.log("------------修改子产品-------");
    console.log(row);

    primarykey = row.id;  //保存主键
    //还原产品名称
    $("#edit_name").val(row.name);
    //还原产品佣金
    $("#edit_commission").val(row.commission);

    $("#edit_thumbadvurl").val(row.thumbadvurl || '');
    //还原自定义分类广告图片
    $("#edit_thumbadv").val(row.thumbadv|| '');
    if(row.thumbadv){
        //自定义广告要还原
        $("#thumbadvImg").attr("src",row.thumbadv);
    }else{
        $("#thumbadvImg").attr("src",projectName+"/static/img/noimg.png");
    }

    //默认的分类图
    $("#edit_thumb").val(row.thumb);
    if(row.thumb){
        $("#thumbImg").attr("src",row.thumb);
    }else{
        $("#thumbImg").attr("src",projectName+"/static/img/noimg.png");
    }

    //有上一级的
    if (row._parent) {
        $("#parentname").html(row._parent.name);
    } else {
        $("#parentname").html("根目录");
    }

    $("#edit_isrecommand").val(row.isrecommand);

    $("#edit_description").val(row.description);

    $("#edit_deleted").val(row.deleted);

    $("#edit_enabled").val(row.enabled);

    //上级的id
    parentid = row.parentid;
    //重置验证的规则样式，但不清除值
    $('#editForm').data('bootstrapValidator').resetForm(false);


    $("#myModalLabel").text("修改产品");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });

}

//新增子公司的
function addChildcategory(row) {
    primarykey = 0;  //主键必须为0
    $("#myModalLabel").text("新增["+row.name+"]分类");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });

    // 清空值
    resetFormValue("#editForm input");
    //重置验证的规则样式，要清除值

    $('#editForm').data('bootstrapValidator').resetForm(true);
    //更改值

    //更改值
    $("#parentname").html(row.name);
    $("#thumbImg").attr("src",projectName+"/static/img/noimg.png");
    $("#thumbadvImg").attr("src",projectName+"/static/img/noimg.png");
    $("#edit_commission").val(0);
    //所属上级
    parentid = row.id;
}


//新增顶级 parentid=0的产品
function newParentcategory() {
    //所属上级
    parentid = 0;

    $("#myModalLabel").text("新增顶级分类");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });
    // 清空值
    resetFormValue("#editForm input");
    //重置验证的规则样式，要清除值
    $('#editForm').data('bootstrapValidator').resetForm(true);

    //更改值
    $("#parentname").html("顶级分类");
    $("#thumbImg").attr("src",projectName+"/static/img/noimg.png");
    $("#thumbadvImg").attr("src",projectName+"/static/img/noimg.png");
    $("#edit_commission").val(0);
}


//新增 或 修改  保存 表单的数据
function saveFormData() {
    //手动调用，验证表单是否通过了

    var bsv = $('#editForm').data('bootstrapValidator');
    //手动调用
    bsv.validate();

    //异步 ajax(remote)效验需要有一个延迟处理的时间
    setTimeout(function () {
        var result = bsv.isValid();
        console.log("saveFormData:" + result);
        //验证不成功
        if (!result) {
            return;
        }
        var dataStr = $("#editForm").serialize()
        //修改就要协带主键
        if (primarykey > 0) {
            dataStr += "&id=" + primarykey;
        }

        //----========注意加上级的id======不一样的地方=======
        dataStr += "&parentid=" + parentid;

        console.log(dataStr);

        //向后台服务器发送ajax请求
        $.ajax({
            type: "POST",
            url: projectName + "/admin/manage/paylog/save",
            //向后台发送的数据
            data: dataStr,
            //返回json格式
            dataType: "json",
            success: function (resp) {
                //{"code":0,"message:"添加数据成功"}
                if (resp.code === 0) {
                    //隐藏模态框
                    $('#myModal').modal('hide');
                    //重新加载数据
                    $tb.bootstrapTable('refresh');

                } else {
                    //提示错误
                    alert(resp.message);
                }
            }
        });

    }, 1000);


}