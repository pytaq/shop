/**
 * ztree加载数据
 */

//全局变量
var projectName=''; //得到项目名称
var roleId;
$(function(){
    roleId=$("#roleId").val();

    //得到项目名称
    projectName=$.trim($("body").attr("data-project"));

    initTree();

    //按钮初始化事件
    initButtonHandler();

});



function initButtonHandler(){

    //全选
    $("#ckAll").click(function(){
        var checked=$(this).prop("checked");

        //ztree取得tree节点的语法
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        treeObj.checkAllNodes(checked);
    });

    //保存
    $("#btnSave").click(saveMenuAuthorityConfirm);

}

//加载tree
function initTree(){
    //设定
    var setting = {
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            },
            key:{
                name:"menuName"
            }
        }
    };

    $.ajax({
        type:"GET",
        url:projectName+"/admin/manage/menu/roleId/"+roleId+"/authority",
        dataType:"json",
        success:function(znodes){
            $.fn.zTree.init($("#menuTree"), setting, znodes);
        }
    });

}

//保存菜单权限
function saveMenuAuthorityConfirm(){

    BootstrapDialog.confirm({
        title : '确认',
        message : '您确定要保存该角色权限吗?',
        type : BootstrapDialog.TYPE_WARNING, // <-- Default value is
        closable : true, // <-- Default value is false，点击对话框以外的页面内容可关闭
        draggable : true, // <-- Default value is false，可拖拽
        btnCancelLabel : '取消', // <-- Default value is 'Cancel',
        btnOKLabel : '确定', // <-- Default value is 'OK',
        btnOKClass : 'btn-warning', // <-- If you didn't specify it, dialog type
        size : BootstrapDialog.SIZE_SMALL,
        callback : function(result) {
            // 点击确定按钮时，result为true
            if (result) {

                saveMenu();

            }
        }
    });

}

function saveMenu(){
    //取得被勾选的节点
    var treeObj = $.fn.zTree.getZTreeObj("menuTree");
    var nodes = treeObj.getCheckedNodes(true);
    console.log(nodes);

    //循环得到ID
    var str='';
    for(var i=0;i<nodes.length;i++){
        if(i==nodes.length-1){
            str+=nodes[i].id;
        }else{
            str+=nodes[i].id+"-";
        }
    }

    //ajax保存
    $.ajax({
        type:"POST",
        url:projectName+"/admin/manage/menu/authority/save",
        data:{"roleId":roleId, "authority":str},
        dataType:"json",
        success:function(resp){

            BootstrapDialog.alert(resp.message);

            if(resp.code===0){
                window.location.href=projectName+"/admin/manage/sysRole";
            }
        }
    });


}

