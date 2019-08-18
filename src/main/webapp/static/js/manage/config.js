var projectName = ''; //得到项目名称
$(function () {
    //得到项目名称
    projectName = $.trim($("body").attr("data-project"));

    //加载按钮事件
    initButtonHandler()

    //表单验证
    validatorForm();
});

function initButtonHandler() {
    //保存按钮
    $("#btnSave").click(saveFormData);

    //上传图片按钮
    KindEditor.ready(function(K) {

        var editor = K.editor({
            allowFileManager : false,
            uploadJson : projectName+'/admin/file/upload',
        });

        //分类图片
        K('#btnChooseImage').click(function() {
            editor.loadPlugin('image', function() {
                editor.plugin.imageDialog({
                    imageUrl : K('#logo').val(),
                    showRemote : false,
                    clickFn : function(url, title, width, height, border, align) {
                        K('#logo').val(url);
                        K('#logoImg').attr("src",url);
                        editor.hideDialog();
                    }
                });
            });
        });
    });
}

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
            title: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '商城名称不能为空'
                    },
                    stringLength: {
                        min: 2,
                        max: 100,
                        trim: 'trim',
                        message: '名称长度必须在2到100个字符之间'
                    }
                }
            },
            address: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '商城地址不能为空'
                    },
                    stringLength: {
                        min: 5,
                        max: 100,
                        trim: 'trim',
                        message: '地址长度必须在5到100个字符之间'
                    }
                }
            },
            webtitle: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '浏览器标题不能为空'
                    },
                    stringLength: {
                        min: 2,
                        max: 100,
                        trim: 'trim',
                        message: '地址长度必须在2到100个字符之间'
                    }
                }
            },
            email: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '商城邮箱不能为空'
                    },
                    stringLength: {
                        min: 5,
                        max: 100,
                        trim: 'trim',
                        message: '邮箱长度必须在5到100个字符之间'
                    }
                }
            },
            keyword: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '商城关键字不能为空'
                    },
                    stringLength: {
                        min: 5,
                        max: 100,
                        trim: 'trim',
                        message: '关键字长度必须在5到100个字符之间'
                    }
                }
            },
            description: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '商城描述不能为空'
                    },
                    stringLength: {
                        min: 5,
                        max: 100,
                        trim: 'trim',
                        message: '描述长度必须在5到100个字符之间'
                    }
                }
            },
            phone: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '商城电话不能为空'
                    },
                    stringLength: {
                        min: 3,
                        max: 11,
                        trim: 'trim',
                        message: '电话长度必须在3到11个字符之间'
                    }
                }
            },
            icp: {
                message: '输入的值无效',
                validators: {
                    notEmpty: {
                        message: '备案号不能为空'
                    },
                    stringLength: {
                        min: 5,
                        max: 15,
                        trim: 'trim',
                        message: '备案号长度必须在5到15个字符之间'
                    }
                }
            },
        }
    });

}

//保存 表单的数据
function saveFormData() {

    //手动调用，验证表单是否通过了
    var bsv = $('#editForm').data('bootstrapValidator');
    //手动调用
    bsv.validate();

    //异步 ajax(remote)效验需要有一个延迟处理的时间
    setTimeout(function () {

        var result=bsv.isValid();
        console.log("saveFormData:"+result);
        //验证不成功
        if(!result){
            return;
        }

        //凑config对象
        var obj = {};
        obj.title = $("#title").val();
        obj.address = $("#address").val();
        obj.webtitle = $("#webtitle").val();
        obj.email = $("#email").val();
        obj.keyword = $("#keyword").val();
        obj.description = $("#description").val();
        obj.phone = $("#phone").val();
        obj.icp = $("#icp").val();
        obj.logo = $("#logo").val();
        obj.tongjicode = $("#tongjicode").val();
        obj.kfcode = $("#kfcode").val();
        console.log(obj);

        //向后台服务器发送ajax请求
        $.ajax({
            type: "POST",
            url: projectName + "/admin/manage/config/save",
            //向后台发送的数据
            data: obj,
            //返回json格式
            dataType: "json",
            success: function (resp) {
                //{"code":0,"message:"添加数据成功"}
                if (resp.code === 0) {
                    //提示成功
                    alert(resp.message);
                    //重新加载数据
                    location.href = projectName + "/admin/manage/config";

                } else {
                    //提示错误
                    alert(resp.message);
                }
            }
        });

    }, 100);


}
