<#assign ctx="${request.contextPath}">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title>菜单</title>

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


    <!--bootstrap validator验证-->
    <link href="${ctx }/static/js/plugins/validator/css/bootstrapValidator.css" rel="stylesheet">
    <!-- jquery.treegrid -->
    <link href="${ctx }/static/js/plugins/jquery-treegrid/css/jquery.treegrid.css" rel="stylesheet">
    <link href="${ctx}/static/css/style.css?v=4.1.0" rel="stylesheet">

</head>


<body class="gray-bg" data-project="${ctx}">
<div class="wrapper wrapper-content animated fadeInRight">
    <!-- 查询条件 -->
    <div class="row">
        <div class="col-md-12">
            <div class="panel-body">
                <form class="form-inline">
                <@shiro.hasPermission name="menu:add">
                    <button type="button" class="newParentMenu btn   btn-success"
                            id="btnAdd">
                        <i class="fa fa-plus"></i>&nbsp;新增顶级分类
                    </button>
                </@shiro.hasPermission>

                </form>
            </div>
        </div>
    </div>

    <div class="row">

        <div class="panel-body">
            <table id="tb"></table>
        </div>

    </div>
</div>
<!-- 新增和修改的模态框 -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">标题</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="editForm">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">上级菜单</label>
                        <div class="col-sm-10">
                            <h3 style="color: red;" id="parentMenuName"></h3>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单名称</label>
                        <div class="col-sm-10">
                            <input data-bv-trigger="blur" type="text" class="form-control"
                                   id="edit_menuName" placeholder="请输入名称" name="menuName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">URL地址</label>
                        <div class="col-sm-10">
                            <input data-bv-trigger="blur" type="text" class="form-control"
                                   id="edit_actionName" placeholder="请输入URL地址" name="actionName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">权限标识</label>
                        <div class="col-sm-10">
                            <input data-bv-trigger="blur" type="text" class="form-control"
                                   id="edit_authority" placeholder="请输入权限标识" name="authority">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单状态</label>
                        <div class="col-sm-10">
                            <div class="form-group">
                                <label class="radio-inline">
                                    <input type="radio" id="display1" value="1" name="display" checked>可见
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" id="display0" value="0" name="display">不可见
                                </label>
                            </div>
                        </div>
                    </div>


                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btnSave">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 全局js -->
<script src="${ctx }/static/js/jquery.min.js?v=2.1.4"></script>


<script src="${ctx }/static/js/bootstrap.min.js?v=3.3.6"></script>
<!-- jquery.treegrid-->
<script src="${ctx }/static/js/plugins/jquery-treegrid/js/jquery.treegrid.min.js?v=0.3.0"></script>
<script src="${ctx }/static/js/plugins/jquery-treegrid/js/jquery.treegrid.bootstrap3.js?v=0.3.0"></script>

<!-- bootstrap-table -->
<script src="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.js?v=1.14.2"></script>
<script src="${ctx }/static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js?v=1.14.2"></script>


<!-- bootstrap-table-treegrid -->
<script src="${ctx }/static/js/plugins/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.js?v=1.14.2"></script>



<script src="${ctx }/static/js/plugins/validator/js/bootstrapValidator.js"></script>
<script src="${ctx }/static/js/plugins/validator/js/language/zh_CN.js"></script>
<!-- Peity -->
<script src="${ctx }/static/js/plugins/peity/jquery.peity.min.js"></script>
<!--bootstrap-switch-->
<script src="${ctx }/static/js/plugins/bootstrap-switch/dist/js/bootstrap-switch.js"></script>
<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>
<!-- 自定义 company.js -->
<script src="${ctx }/static/js/manage/menu.js"></script>


</body>

</html>


