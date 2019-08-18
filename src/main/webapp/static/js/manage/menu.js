/**
 * memu.js
 */

//全局变量
let $tb;
let parentId = 0;     //父级菜单的编号,0代表顶级的
let projectName = ''; //得到项目名称
let menuLevel = 0; //级别
$(function () {

    $tb = $("#tb");
    //得到项目名称
    projectName = $.trim($("body").attr("data-project"));

    //初始化配置信息
    initTable();

    //按钮初始化事件
    initButtonHandler();
    //验证
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
            menuName: {
                message: '输入的值无效',
                validators: {
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
                        url: projectName + '/admin/manage/menu/exist',
                        message: '该值已被占用，请重新输入',
                        data: function () {
                            return {
                                id: primarykey,
                                parentId: parentId
                            };
                        }
                    }
                } //validators验证结束

            }//menuName结束

        }
    });

}


function initButtonHandler() {

    //保存按钮
    $("#btnSave").click(saveFormData);

    //新增顶级按钮
    $("#btnAdd").click(newParentMenu);

}

function initTable() {

    $tb.bootstrapTable({
        method: "POST",  //请求后台的数据的方式
        url: projectName + "/admin/manage/menu/search",         //后台的服务器地址
        sidePagination: "server",              //从后台服务器读取
        contentType: "application/x-www-form-urlencoded",        //提交数据查询参数的格式
        striped: true,
        idField: 'id',       //主键json的列名
        showColumns: false,
        strictSearch: true,
        queryParams: function (params) { // 自定义查询参数
            params["menuName"] = $("#search_menuName").val();
            return params;
        },
        columns: [
            {
                field: 'menuName',
                title: '菜单名称'
            },
            {
                field: 'actionName',
                title: 'URL地址'

            },
            {
                field: 'authority',
                title: '权限标识'
            }, {
                title: "状态",
                field: 'display',
                align: 'center',
                formatter: displaySwicth,  //格式化显示的内容
            }, {
                title: "操作",
                field: 'operate',
                align: 'center',
                formatter: operateFormatter,  //格式化显示的内容
                events: operateFormatterEvents   //绑定事件
            }
        ],
        treeShowField: 'menuName',    //显示json字段名称
        parentIdField: 'parentId',        //json上级关联字段
        //重置树形节点视图
        onResetView: function () {
            $tb.treegrid({
                initialState: 'collapsed',//收缩collapsed,展开expanded
                treeColumn: 0,//指明第几列数据改为树形
                expanderExpandedClass: 'glyphicon glyphicon-tag',
                expanderCollapsedClass: 'glyphicon glyphicon-book',
                onChange: function () {
                    var datas = $tb.bootstrapTable('getData');
                    console.log("datas"+datas);
                    $tb.bootstrapTable('resetWidth');

                    console.log("节点展开");
                    initDisplaySwicth(datas);
                }
            });
        },
        onLoadSuccess:function (data) {
            initDisplaySwicth(data);
        }
    });

}
//初始化boostrap-switch
function initDisplaySwicth(data){
    for(let i=0;i<data.length;i++){
        let dataValue = data[i];
        let states= dataValue.display;
        if(states=='1'){//根据j对应数据库里的状态改变相应switch状态
            states = true;
        }else{
            states = false;
        }
        var name = 'my-checkbox'+dataValue.id;
        $('[name="'+name+'"]').bootstrapSwitch({
            onText:"可见",
            offText:"不可见",
            onColor:"success",
            offColor:"danger",
            size:"small",
            onSwitchChange:function(event,state) {
                let id = this.value;
                let dataStr = "id=" + id;
                let newDisplay;
                if (state == true) {
                    newDisplay = 1;
                } else {
                    newDisplay = 0;

                }

                $.ajax({
                    type: "POST",
                    url: projectName + "/admin/manage/menu/display",
                    //向后台发送的数据
                    data: dataStr + "&display=" + newDisplay,
                    //返回json格式
                    dataType: "json",
                    success: function (resp) {
                        /*//{"code":0,"message:"添加数据成功"}
                        if (resp.code === 0) {

                        } else {
                            //重新加载数据
                            $tb.bootstrapTable('refresh');
                        }*/
                    }
                })
            }
        }).bootstrapSwitch('state',states);

    }

}

function displaySwicth(value, row, index) {
    return "<input value='"+row.id+"' type='checkbox' name='my-checkbox"+row.id+"' />";

}

//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index) {

    if (row.menuLevel == 1) {
        return [
            '<button type="button" class="menuOfAddChild btn   btn-primary" style="margin-right:15px;"><i class="fa fa-plus" ></i>&nbsp;新增子类</button>',
            '<button type="button" class="menuOfedit btn   btn-primary" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;编辑</button>'
        ].join('');
    } else if (row.menuLevel == 2) {
        return [
            '<button type="button" class="menuOfAddChild btn   btn-primary" style="margin-right:15px;"><i class="fa fa-plus" ></i>&nbsp;新增子类</button>',
            '<button type="button" class="menuOfedit btn   btn-primary" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;编辑</button>'
        ].join('');
    } else {
        return '<button type="button" class="menuOfedit btn   btn-primary" style="margin-right:15px;"><i class="fa fa-pencil-square-o" ></i>&nbsp;编辑</button>';
    }


}

//初始化操作按钮的方法
window.operateFormatterEvents = {
    'click .menuOfedit': function (e, value, row, index) {
        editMenu(row);
    },

    'click .menuOfAddChild': function (e, value, row, index) {
        addChildMenu(row);
    },


};



//修改的function
function editMenu(row) {

    primarykey = row.id;  //保存主键

    //还原名称
    $("#edit_menuName").val(row.menuName);
    //上一级的菜单名称
    if (row._parent) {
        $("#parentMenuName").html(row._parent.menuName);
    } else {
        $("#parentMenuName").html("顶级目录");
    }
    $("#edit_actionName").val(row.actionName);
    $("#edit_authority").val(row.authority);


    //上级的id
    parentId = row.parentId;
    menuLevel = row.menuLevel;

    //重置验证的规则样式，但不清除值
    $('#editForm').data('bootstrapValidator').resetForm(false);

    $("#myModalLabel").text("修改菜单");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });
    //还原单选按钮
    let num = row.display;
    if(num==1){
        $('input[type=radio][name="display"]:checked').removeAttr("checked");
        $('input[type=radio][name="display"][value="1"]').prop("checked",true);
    }else{
        $('input[type=radio][name="display"]:checked').removeAttr("checked");
        $('input[type=radio][name="display"][value="0"]').prop("checked",true);

    }

}

//新增子菜单
function addChildMenu(row) {

    primarykey = 0;  //主键必须为0
    $("#myModalLabel").text("新增菜单");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });
    // 清空值
    resetFormValue("#editForm input");
    //重置验证的规则样式，要清除值
    $('#editForm').data('bootstrapValidator').resetForm(true);

    //更改值
    $("#parentMenuName").html(row.menuName);

    //所属上级
    parentId = row.id;
    menuLevel = row.menuLevel + 1;
}


//新增顶级 parentId=0
function newParentMenu() {
    primarykey = 0;  //主键必须为0
    $("#myModalLabel").text("新增顶级菜单");
    $('#myModal').modal({
        backdrop: 'static',
        show: true
    });

    // 清空值
    resetFormValue("#editForm input");
    //重置验证的规则样式，要清除值
    $('#editForm').data('bootstrapValidator').resetForm(true);

    //更改值
    $("#parentMenuName").html("顶级目录");
    //所属上级
    parentId = 0;
    menuLevel = 1;
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
        dataStr += "&parentId=" + parentId;
        //级别
        dataStr += "&menuLevel=" + menuLevel;

        //向后台服务器发送ajax请求
        $.ajax({
            type: "POST",
            url: projectName + "/admin/manage/menu/save",
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

    }, 100)
}
