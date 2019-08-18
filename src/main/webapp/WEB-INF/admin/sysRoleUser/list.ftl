<#assign ctx="${request.contextPath}">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title>H+ 后台主题UI框架 - 主页</title>

    <meta name="keywords" content="">
    <meta name="description" content="">


    <link href="${ctx }/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx }/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/css/animate.css" rel="stylesheet">


    <!-- bootstrap-table -->
    <link href="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet">

    <!-- bootstrap-dialog -->
    <link href="${ctx }/static/js/plugins/dialog/css/bootstrap-dialog.min.css" rel="stylesheet">


    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">

</head>


<body class="gray-bg" data-project="${ctx }">

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
     <div class="col-md-12">
        <ol class="breadcrumb">
            <li><a href="#">Home</a></li>
            <li><a href="${ctx}/admin/manage/sysRole">角色管理</a></li>
            <li class="active">分配用户</li>
        </ol>
     </div>
    </div>
     <!-- 显示表格 -->
    <div class="row">

        <div class="col-md-5">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">[${role.rolename!}]角色已拥有用户列表</h3>
                    <input type="hidden" id="roleId" value="${role.id!}">
                </div>
                <div class="panel-body">
                    <table id="tb"></table>
                </div>
            </div>

        </div>


        <div class="col-md-7">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">可选用户列表</h3>
                </div>
                <div class="panel-body">
                    <table id="tbDetail"></table>
                </div>
            </div>

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

<!-- bootstrap-dialog验证 -->
<script src="${ctx }/static/js/plugins/dialog/js/bootstrap-dialog.min.js"></script>


<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 role.js -->
<script src="${ctx }/static/js/manage/roleUser.js?v=1.0.0"></script>

</body>

</html>   
    
    