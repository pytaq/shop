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


    <link href="${ctx }/static/css/bootstrap.min.css?v=3.3.6"
          rel="stylesheet">
    <link href="${ctx }/static/js/plugins/bootstrap-switch/dist/css/bootstrap3/bootstrap-switch.css" rel="stylesheet">
    <link href="${ctx }/static/css/font-awesome.min.css?v=4.4.0"
          rel="stylesheet">
    <link href="${ctx }/static/css/animate.css" rel="stylesheet">

    <!-- bootstrap-table -->
    <link href="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet">

    <!-- bootstrap-dialog -->
    <link href="${ctx }/static/js/plugins/dialog/css/bootstrap-dialog.min.css" rel="stylesheet">

    <!-- ztree -->
    <link href="${ctx }/static/js/plugins/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">

    <link href="${ctx}/static/css/style.css?v=4.1.0" rel="stylesheet">

    <style>
        .ztree li span{
            font-size:16px;
            margin:10px 0;
        }

        .wrapper .panel-heading .checkAll{
            margin-left:30px;
        }
    </style>

</head>


<body class="gray-bg" data-project="${ctx }">

<div class="wrapper wrapper-content animated fadeInRight">

    <div class="row">
        <div class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="${ctx}/admin/manage/sysRole">角色管理</a></li>
                <li class="active">分配菜单权限</li>
            </ol>
        </div>
    </div>

    <!-- 显示表格 -->
    <div class="row">

        <div class="col-md-12">
            <#--角色对应的菜单表-->
            <div class="panel panel-success">
                <div class="panel-heading">


                    <h3 class="panel-title">[${role.rolename!}]角色菜单权限要配

                        <input type="checkbox" value="0"  id="ckAll" class="checkAll"> 全选
                    </h3>
                    <input type="hidden" id="roleId" value="${role.id!}">
                </div>

                <div class="panel-body">
                    <#--菜单ztree-->
                      <ul id="menuTree" class="ztree"></ul>

                </div>

                <div class="panel-footer">
                    <button type="button" class="btn btn-primary" id="btnSave">保存</button>
                </div>
            </div>
        </div>

    </div>

</div>



<!-- 全局js -->
<script src="${ctx }/static/js/jquery.min.js?v=2.1.4"></script>

<script src="${ctx }/static/js/bootstrap.min.js?v=3.3.6"></script>


<!-- Peity -->
<script src="${ctx }/static/js/plugins/peity/jquery.peity.min.js"></script>

<!-- ztree -->
<script src="${ctx }/static/js/plugins/ztree/js/jquery.ztree.all.js"></script>

<!-- bootstrap-dialog验证 -->
<script src="${ctx }/static/js/plugins/dialog/js/bootstrap-dialog.min.js"></script>

<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 role.js -->
<script src="${ctx }/static/js/manage/RoleMenu.js?v=1.0.0"></script>

</body>

</html>

