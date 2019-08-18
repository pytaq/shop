
var projectName = ''; // 得到项目名称
var primarykey =0; // 新增操作,如果>0必定修改
var imageCount=0;   //新增的几张图
var contentEditor;        //富文本框
//初始化
$(function () {
    projectName = $.trim($("body").attr("data-project"));

    initKindeditor();

    //批量上传图片
    uploadAllImages();

    //新增删除图片,移出那个div
    deleteFunction();

    //产品分类级联
    categoryCascade();
});

//产品分类级联
function categoryCascade(){
    //一级 (动，二级变)
    $("#firstCate").change(function(){
        var pid=$(this).val();
        $("#thirdCate").empty();  //第三级肯定变
        categoryChange(pid,"#secondCate" );
    });

    //二级(动，三级变)
    $("#secondCate").change(function(){
        var pid=$(this).val();
        categoryChange(pid,"#thirdCate" );
    });

}

/**
 * 根据变化填充数据
 * @param pid
 * @param selector
 */
function categoryChange(pid,selector){
    $.ajax({
        type:"get",
        url:projectName+"/admin/manage/category/parentId/"+pid,
        dataType:"json",
        success:function(resp){
            if(resp.code===0){
                var cateSelect=$(selector);  //下拉列
                cateSelect.empty();           //清空节点
                //循环填充
                $.each(resp.data, function(index, obj){
                    var str=`<option value="${obj.id}">${obj.name}</option>`;
                    cateSelect.append($(str));

                    //下标为0，并且是第二级，加载第三数据
                    if(index==0 && selector=='#secondCate'){
                        categoryChange(obj.id,'#thirdCate');
                    }
                });
            }
        }
    });
}

function deleteFunction(){
    $(".deleteImg").off();  //移出所有事件

    $(".deleteImg").click(function(){
        $(this).parents("div.itemImage").remove();
        imageCount=imageCount-1; //图片长度-1
    });
}

//1、初始化富文本框
function initKindeditor(){
    KindEditor.ready(function(K) {
        contentEditor = K.create('textarea[name="content"]', {
            uploadJson : projectName+'/admin/image/upload',   //上传地址
            allowFileManager: false
        });
    });
}

//2、批量上传图片 http://kindeditor.net/ke4/examples/multi-image-dialog.html
function uploadAllImages(){

    KindEditor.ready(function(K) {
        var editor = K.editor({
            allowFileManager : false,
            uploadJson : projectName+'/admin/image/upload',   //上传地址
        });
        K('#btnUploads').click(function() {
            editor.loadPlugin('multiimage', function() {
                editor.plugin.multiImageDialog({
                    clickFn : function(urlList) {
                        console.log(urlList);
                        imageCount=imageCount+urlList.length; //记录图片长度
                        var prevDiv=K("#prevImage");
                        K.each(urlList, function(i, data) {
                            //es6语法
                            var str=`
                           <div class="col-md-3 itemImage">
                                <div class="thumbnail">
                                <img data-src="${data.url}" src="${data.url}" style="width:250px;height:250px;" data-holder-rendered="true"  >
                                <div class="caption">
                                <p> 
                                    <a  class="btn btn-default deleteImg"  >删除</a>
                                    <input type="hidden" name="thumbArr" value="${data.url}" >
                                </p>
                            </div>
                            </div>
                            </div>`;
                            //追加到页面
                            prevDiv.append( $(str));

                        });

                        //再重新注册事件
                        deleteFunction();

                        editor.hideDialog();
                    }
                });
            });
        });
    });
}



//表单验证
function validatorForm(){

    $('#addform').bootstrapValidator({
        excluded: [':disabled'],//排除其他样式
        message: '输入的值无效',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok', //验证通过的图标
            invalid: 'glyphicon glyphicon-remove',  //验证失败的图标
            validating: 'glyphicon glyphicon-refresh'  //正在验证中的图标
        },
        fields: {
            //添加验证的表单的name
            pcate:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },
                } //validators验证结束

            }, //username结束
            ccate:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            type:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            status:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            displayorder:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            title:{
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
                        type: 'POST',
                        url: projectName+'/admin/manage/shopgoods/exit',
                        message: '该值已被占用，请重新输入',
                        data:function(){
                            return {
                                id: primarykey
                            };
                        }
                    }
                } //validators验证结束

            }, //roleName结束
            description:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            content:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            goodssn:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '名称不能为空'
                    },
                    stringLength: {
                        min: 4,
                        max: 10,
                        trim: 'trim',
                        message: '名称长度必须在4到10个字符之间'
                    },
                    remote: {
                        type: 'POST',
                        url: projectName+'/admin/manage/shopgoods/exit',
                        message: '该值已被占用，请重新输入',
                        data:function(){
                            return {
                                id: primarykey
                            };
                        }
                    }
                } //validators验证结束

            }, //roleName结束
            weight:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            productsn:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            marketprice:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            productprice:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            total:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            },//password结束
            sales:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            }, //password结束
            deleted:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '值不能为空'
                    },

                } //validators验证结束

            }, //password结束

        }
    });
};

