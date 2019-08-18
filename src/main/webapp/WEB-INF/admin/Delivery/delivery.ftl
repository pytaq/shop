<#assign ctx="${request.contextPath}">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title>商城配送方式</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <link href="${ctx }/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx }/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/css/animate.css" rel="stylesheet">

    <!-- bootstrap-table -->
    <link href="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet">

    <!-- bootstrap-validator验证 -->
    <link href="${ctx }/static/js/plugins/validator/css/bootstrapValidator.css" rel="stylesheet">
    <!-- kindeditor -->
    <link href="${ctx }/static/js/plugins/kindeditor/themes/default/default.css" rel="stylesheet">

    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">

</head>


<body class="gray-bg" data-project="${ctx }">

<div class="wrapper wrapper-content animated fadeInRight">

    <!-- 查询条件 -->
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">查询</h3>
                </div>

                <div class="panel-body ">
                    <form class="form-inline ">
                        <div class="form-group">
                            <label>配送方式</label>
                            <input type="text" class="form-control" id="search_deliveryexplain" name="deliveryexplain"
                                   placeholder="支持模糊查询">
                        </div>
                        <button type="button" class="btn btn-primary" id="btnSearch">查询</button>
                        <button type="button" id="btnAdd" class="newParentcategory btn   btn-success ">
                            <i class="fa fa-plus"></i>&nbsp;添加配送方式
                        </button>
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


<!-- 新增或修改的  模态框Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!--标题-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">标题</h4>
            </div>

            <!--内容区-->
            <div class="modal-body">
                <form class="form-horizontal" id="editForm">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">配送说明</label>
                        <div class="col-sm-8">
                            <input data-bv-trigger="blur" type="text" class="form-control" id="edit_deliveryexplain"
                                   name="deliveryexplain" placeholder="请输配送方式">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">配送费</label>
                        <div class="col-sm-8">
                            <input data-bv-trigger="blur" type="text" class="form-control" id="edit_deliveryfee"
                                   name="deliveryfee" placeholder="请输入配送费">
                        </div>
                    </div>

                </form>
            </div>

            <!--底部-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="btnSave" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade bs-example-modal-sm" id="successModel" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            ...
        </div>
    </div>
</div>


<!-- 全局js -->
<script src="${ctx }/static/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx }/static/js/bootstrap.min.js?v=3.3.6"></script>


<!-- bootstrap-table -->
<script src="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.js?v=1.14.2"></script>
<script src="${ctx }/static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js?v=1.14.2"></script>


<!-- bootstrap-validator验证 -->
<script src="${ctx }/static/js/plugins/validator/js/bootstrapValidator.js"></script>
<script src="${ctx }/static/js/plugins/validator/js/language/zh_CN.js"></script>

<!-- kindeditor -->
<script src="${ctx }/static/js/plugins/kindeditor/kindeditor-all.js"></script>
<script src="${ctx }/static/js/plugins/kindeditor/lang/zh-CN.js"></script>
<!-- Peity -->
<script src="${ctx }/static/js/plugins/peity/jquery.peity.min.js"></script>

<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 role.js -->
<script src="${ctx }/static/js/manage/delivery.js?v=1.0.0"></script>

</body>

</html>

