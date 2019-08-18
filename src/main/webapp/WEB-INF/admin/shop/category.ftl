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

    <!-- jquery.treegrid -->
    <link href="${ctx }/static/js/plugins/jquery-treegrid/css/jquery.treegrid.css" rel="stylesheet">

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

            <button type="button" id="btnAdd" class="newParentcategory btn   btn-success">
                <i class="fa fa-plus"></i>&nbsp;新增产品
            </button>

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
                                <label class="col-sm-4 control-label">上级分类</label>
                                <div class="col-sm-8">
                                    <h3 style="color:red;" id="parentname"></h3>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">分类名称</label>
                                <div class="col-sm-8">
                                    <input data-bv-trigger="blur" type="text" class="form-control" id="edit_name"
                                           name="name"
                                           placeholder="请输入产品名称">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" style="height: 100px; line-height: 100px;">分类图片(必填)</label>
                                <div class="col-sm-8">
                                    <input type="hidden" id="edit_thumb" name="thumb" value=""/>
                                    <img src="#" width="100" id="thumbImg">
                                    <button type="button" class="btn btn-info" id="btnChooseImage">选择图片</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" style="height: 100px; line-height: 100px;">分类广告图(可选)</label>

                                <div class="col-sm-8">
                                    <input type="hidden" id="edit_thumbadv" name="thumbadv" value=""/>
                                    <img src="#" width="100" id="thumbadvImg">
                                    <button type="button" class="btn btn-info" id="btnChoosethumbadvImage">选择图片</button>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">广告地址(可选)</label>

                                <div class="col-sm-8">
                                    <input data-bv-trigger="blur" type="text" class="form-control" id="edit_thumbadvurl"
                                           name="thumbadvurl" placeholder="请输入分类广告地址">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">所获得的佣金</label>

                                <div class="col-sm-8">
                                    <input type="number" class="form-control" id="edit_commission"
                                           name="commission" placeholder="请输入产品佣金">
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">产品分类介绍</label>

                                <div class="col-sm-8">
                                    <input data-bv-trigger="blur" type="text" class="form-control" id="edit_description"
                                           name="description" placeholder="请输入产品分类介绍">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">是否可删除</label>
                                <div class="col-sm-8">
                                    <select class="form-control" id="edit_deleted" name="deleted">
                                        <option value="1" SELECTED>是</option>
                                        <option value="0">否</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">是否开启</label>
                                <div class="col-sm-8">
                                    <select class="form-control" id="edit_enabled" name="enabled">
                                        <option value="1" SELECTED>是</option>
                                        <option value="0">否</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">是否推荐</label>
                                <div class="col-sm-8">
                                    <select class="form-control" id="edit_isrecommand" name="isrecommand">
                                        <option value="1" SELECTED>是</option>
                                        <option value="0">否</option>
                                    </select>
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


<!--jquery.treegrid   -->
<script src="${ctx }/static/js/plugins/jquery-treegrid/js/jquery.treegrid.min.js?v=0.3.0"></script>
<script src="${ctx }/static/js/plugins/jquery-treegrid/js/jquery.treegrid.bootstrap3.js?v=0.3.0"></script>

<!-- bootstrap-table -->
<script src="${ctx }/static/js/plugins/bootstrap-table/bootstrap-table.js?v=1.14.2"></script>
<script src="${ctx }/static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js?v=1.14.2"></script>

<!-- bootstrap-table-treegrid -->
<script src="${ctx }/static/js/plugins/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.js?v=1.14.2"></script>

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
<script src="${ctx }/static/js/manage/category.js?v=1.0.0"></script>

</body>

</html>

