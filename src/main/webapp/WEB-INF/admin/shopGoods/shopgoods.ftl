<#assign ctx="${request.contextPath}">
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title>商品信息</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <style>

        select{
        //清除select的边框样式
        //清除select聚焦时候的边框颜色
        //将select的宽高等于div的宽高
        width: 100%;
            height: 35px;
        //隐藏select的下拉图标
        //通过padding-left的值让文字居中
        padding-left: 60px ;
            left: 10px;
            right: 10px;
        }
    </style>



    <link href="${ctx }/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx }/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/css/animate.css" rel="stylesheet">


    <!-- bootstrap-table -->
    <link href="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet">

    <!-- bootstrap-validator验证 -->
    <link href="${ctx }/static/js/plugins/validator/css/bootstrapValidator.css" rel="stylesheet">



    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">

</head>


<body class="gray-bg"   data-project="${ctx }" >



<div class="wrapper wrapper-content animated fadeInRight">

    <!-- 查询条件 -->
    <div class="row">
        <div class="col-md-12">

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">查询条件</h3>
                </div>

                <div class="panel-body">
                    <form class="form-inline">
                        <div class="form-group">
                            <label >商品名称</label>
                            <input type="text" class="form-control" id="search_title" name="title" placeholder="支持模糊查询">
                            <select id="status1">
                                <option value="" selected>--请选择--</option>
                                <option value ="1">已上架</option>
                                <option value ="2">已下架</option>
                            </select>


                        </div>

                        <button type="button" class="btn btn-primary" id="btnSearch">查询</button>

                        <a href="${ctx}/admin/manage/saveshopgoods?id=0" target="view_window" ><button type="button" class="btn btn-primary"  >新增</button></a>
                    </form>
                </div>
            </div>

        </div>
    </div>

    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-12">

            <table id="tb">
            </table>

        </div>
    </div>


</div>





<!-- 全局js -->
<script src="${ctx }/static/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx }/static/js/bootstrap.min.js?v=3.3.6"></script>

<!-- bootstrap-table -->
<script src="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.js?v=1.14.2"></script>
<script src="${ctx }/static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js?v=1.14.2"></script>


<!-- Peity -->
<script src="${ctx }/static/js/plugins/peity/jquery.peity.min.js"></script>

<!-- bootstrap-validator验证 -->
<script src="${ctx }/static/js/plugins/validator/js/bootstrapValidator.js"></script>
<script src="${ctx }/static/js/plugins/validator/js/language/zh_CN.js"></script>


<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 user.js -->
<script src="${ctx }/static/js/manage/shopgoods.js?v=1.0.0"></script>

</body>

</html>   
    
    