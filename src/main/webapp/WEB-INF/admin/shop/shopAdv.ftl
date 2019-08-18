<#assign ctx="${request.contextPath}">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title>产品信息表</title>

    <meta name="keywords" content="">
    <meta name="description" content="">


    <link href="${ctx }/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx }/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/css/animate.css" rel="stylesheet">


    <!-- bootstrap-table -->
    <link href="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet">

    <!-- bootstrap-validator验证 -->
    <link href="${ctx }/static/js/plugins/validator/css/bootstrapValidator.css" rel="stylesheet">
    <!-- bootstrap-dialog -->
    <link href="${ctx }/static/js/plugins/dialog/css/bootstrap-dialog.min.css" rel="stylesheet">
    <!-- kindeditor -->
    <link href="${ctx }/static/js/plugins/kindeditor/themes/default/default.css" rel="stylesheet">

    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">

</head>


<body class="gray-bg" data-project="${ctx }">


<div class="wrapper wrapper-content animated fadeInRight">
    <button type="button" id="addThumb" class="shopAdvOfAdd btn   btn-primary" style="margin-right:15px;"><i
                class="fa fa-plus"></i>&nbsp;新增广告图
    </button>
    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-12">

            <table id="tb">
            </table>

        </div>
    </div>


</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
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
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" style="height: 100px; line-height: 100px;">广告轮播图(必填)</label>
                                <div class="col-sm-6">
                                    <input type="hidden" id="edit_thumb" name="thumb" value=""/>
                                    <img src="#" data-bv-trigger="blur" width="100" id="thumbImg">
                                    <button type="button" class="btn btn-info" id="btnChooseImage">选择图片</button>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="row">

                                <div class="form-group">
                                    <label class="col-sm-4 control-label">跳转地址</label>

                                    <div class="col-sm-6">
                                        <input data-bv-trigger="blur" type="text" class="form-control" id="edit_link"
                                               name="link" placeholder="请输入分类广告地址">
                                    </div>
                                </div>

                            </div>
                            <div class="row">

                                <div class="form-group">
                                    <label class="col-sm-4 control-label">是否显示</label>
                                    <div class="col-sm-6">
                                        <select class="form-control" id="edit_displayorder" name="displayorder">
                                            <option value="1" SELECTED>是</option>
                                            <option value="0">否</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="row">

                                <div class="form-group">
                                    <label class="col-sm-4 control-label">是否开启</label>
                                    <div class="col-sm-6">
                                        <select class="form-control" id="edit_enabled" name="enabled">
                                            <option value="1" SELECTED>是</option>
                                            <option value="0">否</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
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

<!-- bootstrap-dialog验证 -->
<script src="${ctx }/static/js/plugins/dialog/js/bootstrap-dialog.min.js"></script>

<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 role.js -->
<script src="${ctx }/static/js/manage/shopAdv.js?v=1.0.0"></script>

</body>

</html>

