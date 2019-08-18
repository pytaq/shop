/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var primarykey=0;  //新增操作,如果>0必定修改
var projectName=''; //得到项目名称
var shopstatus='';
$(function(){
    //得到项目名称
    projectName=$.trim($("body").attr("data-project"));
    $tb=$("#tb");
    select();
    //初始化配置信息
    initTable();
    //按钮初始化事件
    initButtonHandler();


});

//表单验证的js(bootstrap-validator.js)
function validatorForm(){
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
            roleName:{
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
                        url: projectName+'/admin/manage/role/exist',
                        message: '该值已被占用，请重新输入',
                        data:function(){
                            return {
                                id: primarykey
                            };
                        }
                    }
                } //validators验证结束

            }, //roleName结束
            authority:{
                message: '输入的值无效',
                validators:{
                    notEmpty: {
                        message: '标识不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 20,
                        trim: 'trim',
                        message: '标识长度必须在1到20个字符之间'
                    },
                    remote: {
                        type: 'POST',
                        url: projectName+'/admin/manage/sysRole/exist',
                        message: '该值已被占用，请重新输入',
                        data:function(){
                            return {
                                id: primarykey
                            };
                        }
                    },
                } //validators验证结束

            } //authority结束

        }
    });

}

function initButtonHandler(){

    //查询
    $("#btnSearch").click(function(){
        //刷新
        select();
    });


    $("#btnSearch").click(function(){
        //刷新
        $tb.bootstrapTable('refresh',{query:{offset:0}});
    });


}

function initTable(){

    $tb.bootstrapTable({
        striped:true,   //隐藏变色
        method:"POST",  //请求后台的数据的方式
        url: projectName+"/admin/manage/shopgoods/search",         //后台的服务器地址
        sidePagination:"server",              //从后台服务器读取
        contentType:"application/x-www-form-urlencoded",        //提交数据查询参数的格式
        queryParamsType:"limit", //分页查询类型limit(limit[取几笔]，offset[排除前几笔]， sort[排序列]，order[排序的方式 asc/desc]),
                                 //分页查询类型"page(pageSize[每页要显示几笔]，pageNumber[查询第几页]，  sortName[排序列]，sortOrder[排序的方式 asc/desc])
        queryParams:function(params){   //自定义查询参数
            params["title"]=$("#search_title").val();
            params["status"]=shopstatus;
            console.log(params);
            return params;
        },

        pagination:true,         //要显示分页条
        pageNumber:1,            //当前第1页
        pageSize:2,              //每页显示几笔
        pageList:[2,5,10, 25, 50, 100],   //每页显示的笔数列表
        clickToSelect:true,               //点击选中一行
        singleSelect:false,               //只能true单选,false多选
        columns:[
            {radio:true},
            {field:"id",title:"商品编号"},
            {field:"title",title:"商品名称"},
            {field:"thumb",title:"图片", formatter:imageFormatter},
            {field:"total",title:"库存"},
            {filed:"shoptype",title:"商品属性",
                formatter:typeFormatter},
            {field:"marketprice", title:"销售价格"},
            {field:"shopstate",title:"状态",
                formatter:stateFormatter},
            {field:"options",title:"操作",
                formatter: operateFormatter   //格式化显示的内容
                //events:operateFormatterEvents   //绑定事件
            }
        ]     //表格中要显示的列一些属性
    });

}

//下拉列表获取值
function select(){
    var options=$("#status1 option:selected"); //获取选中的项
    shopstatus=options.val();
    console.log(shopstatus);
}


//图片
function imageFormatter(value,row,index){
   if(value.length==0){
       return "<img src='"+projectName+"/static/img/noimg.png'  width='150'  >";
   }else{
       return "<img src='"+value+"'  width='150'  >";
   }
}

//商品状态
function stateFormatter(value,row,index) {
    console.log(JSON.stringify(row))
    if(row.status===1){
        return '<span  class="compnayOfedit label label-success">上架中</span>';
    }else {
        return '<span  class="compnayOfedit label label-default">已下架</span>';
    }
}

//商品属性
function typeFormatter(value,row,index) {
    var str='';
    if(row.isrecommand==1){
        str+= '<span  class="compnayOfedit label  label-primary">首页推荐</span>';
    }
    if(row.isjingping==1){
        str+='<span  class="compnayOfedit label  label-info">精品</span>';
    }
    if(row.isfirst==1){
        str+='<span  class="compnayOfedit label  label-warning">首发</span>';
    }
    if(row.ishot==1){
        str+='<span  class="compnayOfedit label  label-danger">热卖</span>';
    }
    if(row.issendfree==1){
        str+='<span  class="compnayOfedit label  label-primary">包邮</span>';
    }
    if(row.isverify==1){
        str+='<span  class="compnayOfedit label  label-info">促销</span>';
    }
    if(row.isnew==1){
        str+='<span  class="compnayOfedit label  label-danger">新品</span>';
    }
    return str;
}


//自定义操作列 value当前列的值， row当前列的json对象, index下标
function operateFormatter(value, row, index){

    var id2=row.id;
    var st=projectName;
    return '<a href="'+st+'/admin/manage/saveshopgoods?id='+id2+'" target="view_window" > <button type="button" class="compnayOfedit btn  btn-primary"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button></a>';

}









