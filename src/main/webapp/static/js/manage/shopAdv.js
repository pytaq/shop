/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var primarykey = 0;  //新增操作,如果>0必定修改
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
            //添加验证的表单的name
            thumb: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '未选择任何图片'
                    },
                }
            }
        }
    });

}


function initButtonHandler() {
    //保存按钮
    $("#btnSave").click(saveFormData);

    $(".shopAdvOfAdd").click(addshopAdv);
    //2上传图片按钮
    KindEditor.ready(function (K) {

        var editor = K.editor({
            allowFileManager: false,
            uploadJson: projectName + '/admin/file/upload',
        });

        //分类图片
        K('#btnChooseImage').click(function () {
            editor.loadPlugin('image', function () {
                editor.plugin.imageDialog({
                    imageUrl: K('#edit_thumb').val(),
                    showRemote: false,
                    clickFn: function (url, title, width, height, border, align) {
                        K('#edit_thumb').val(url);
                        K('#thumbImg').attr("src", url);
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
        url: projectName + "/admin/manage/shopAdv/search",         //后台的服务器地址
        sidePagination: "server",              //从后台服务器读取
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",// 提交数据查询参数的格式
        queryParamsType: "limit",
        idField: 'id',       //主键json的列名
        pagination: true, // 要显示分页条
        pageNumber: 1, // 当前第1页
        pageSize: 2, // 每页显示几笔
        pageList: [2, 10, 25, 50, 100], // 每页显示的笔数列表
        clickToSelect: true, // 点击选中一行
        singleSelect: false, // 只能true单选,false多选
        columns: [{
            radio: true
        },
            {
                field: 'id',
                title: '编号',
                align: 'center'
            },
            {
                field: 'thumb',
                title: '分类图片',
                align: 'center',
                formatter: imgFormatter //格式化显示的内容
            },
            {
                field: 'link',
                title: '跳转地址',
                align: 'center'
            },
            {
                field: 'displayorder',
                title: '排序显示',
                align: 'center',
                formatter: shopAdvDisplayorder,
                events: operateFormatterDisplayorder
            },
            {
                field: 'enabled',
                title: '是否开启',
                align: 'center',
                formatter: shopAdvEnabled,
                events: operateFormatterEnabled
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

window.operateFormatterEnabled = {
    'click .shopAdvEnabled': function (e, value, row, index) {

        editshopAdvEnabled(row);
    }
}
window.operateFormatterDisplayorder = {
    'click .shopAdvDisplayorder': function (e, value, row, index) {

        editshopAdvDisplayorder(row);
    }
}

function editshopAdvEnabled(row) {
    var enabled = 0;
    if (row.enabled === 1) {
        enabled = 0;
    } else if (row.enabled === 0) {
        enabled = 1;
    }
    $.ajax({
        type: "POST",
        url: projectName + "/admin/manage/shopAdv/updateEnabled",
        //向后台发送的数据
        data: {
            "id": row.id,
            "enabled": enabled
        },
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
}

function editshopAdvDisplayorder(row) {

    var displayorder = 0;
    if (row.displayorder === 1) {
        displayorder = 0;
    } else if (row.displayorder === 0) {
        displayorder = 1;
    }
    $.ajax({
        type: "POST",
        url: projectName + "/admin/manage/shopAdv/updateDisplayorder",
        //向后台发送的数据
        data: {
            "id": row.id,
            "displayorder": displayorder
        },
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
}

//修改
function editshopAdv(row) {
    console.log(row);
    primarykey = 0;  //主键必须为0
    $("#myModalLabel").text("新增广告图片");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });
    $("#edit_link").val(row.link);
    $("#edit_displayorder").val(row.displayorder||0);
    $("#edit_enabled").val(row.enabled||0);

    //重置验证的规则样式，但不清除值
    $('#editForm').data('bootstrapValidator').resetForm(false);

    $("#myModalLabel").text("修改产品");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });



    //更改值
    $("#thumbImg").attr("src", projectName + row.thumb);
}

//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index) {
    return [
        '<button type="button" class="shopAdvOfedit btn   btn-warning" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>'
    ].join('');

}


function shopAdvEnabled(value) {

    if (value == 1) {
        return '<button type="button" class="shopAdvEnabled btn   btn-primary">是</button>'
    } else {
        return '<button type="button" class="shopAdvEnabled btn   btn-primary">否</button>'
    }
}

function shopAdvDisplayorder(value) {

    if (value == 1) {
        return '<button type="button" class="shopAdvDisplayorder btn   btn-primary">是</button>'
    } else {
        return '<button type="button" class="shopAdvDisplayorder btn   btn-primary">否</button>'
    }
}


//分产品图
function imgFormatter(value, row, index) {
    if (value) {
        return '<img src="' + value + '"  width="150"/>';
    } else {
        return "";
    }
}

//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .shopAdvOfedit': function (e, value, row, index) {

        editshopAdv(row);
    }
};

//新增的function
function addshopAdv(row) {

    primarykey = row.id;  //保存主键

    $("#edit_link").val(row.link || '');
    if (row.thumb) {
        $("#thumbadvImg").attr("src", row.thumb);
    } else {
        $("#thumbadvImg").attr("src", projectName + "/static/img/noimg.png");
    }
    // 清空值
    resetFormValue("#editForm");
    //重置验证的规则样式，要清除值

    $('#editForm').data('bootstrapValidator').resetForm(true);
    //更改值
    $("#myModalLabel").text("新增产品");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });

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

        //向后台服务器发送ajax请求
        $.ajax({
            type: "POST",
            url: projectName + "/admin/manage/shopAdv/save",
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

    }, 100);


}