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
                            <label >email</label>
                            <input type="text" class="form-control" id="search_email" name="email" placeholder="支持模糊查询">
                        </div>

                        <div class="form-group">
                            <label >真实姓名</label>
                            <input type="text" class="form-control" id="search_realname" name="realname" placeholder="支持模糊查询">
                        </div>
                        <div class="form-group">
                            <label >电话号码</label>
                            <input type="text" class="form-control" id="search_mobile" name="mobile" placeholder="支持模糊查询">
                        </div>

                        <button type="button" class="btn btn-primary" id="btnSearch">查询</button>

                    </form>
                </div>
            </div>

        </div>
    </div>

    <div class="wrapper wrapper-content animated fadeInRight">

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
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">标题</h4>
            </div>

            <!--内容区-->
            <div class="modal-body">
                <form class="form-horizontal"  id="editForm">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">姓名</label>
                                <div class="col-sm-8">
                                     <label id="edit_realname" class="control-label"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">电话</label>
                                <div class="col-sm-8">
                                     <label id="edit_mobile" class="control-label"></label>
                                </div>
                            </div>

                        </div>
                    </div>


                  <div class="row">
                      <div class="col-md-6">
                          <div class="form-group">
                              <label class="col-sm-4 control-label">邮箱</label>

                              <div class="col-sm-8">
                                  <label id="edit_email" class="control-label"></label>
                              </div>
                          </div>
                      </div>
                      <div class="col-md-6">
                          <div class="form-group">
                              <label class="col-sm-4 control-label">状态</label>

                              <div class="col-sm-8">
                                  <label id="edit_status" class="control-label"></label>
                              </div>
                          </div>
                      </div>
                  </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">是否临时账户</label>

                                <div class="col-sm-8">
                                    <label id="edit_istemplate" class="control-label"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">积分</label>

                                <div class="col-sm-8">
                                    <label id="edit_credit" class="control-label"></label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">账号经验值</label>

                                <div class="col-sm-8">
                                    <label id="edit_experience" class="control-label"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">余额</label>

                                <div class="col-sm-8">
                                    <label id="edit_gold" class="control-label"></label>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row" id="weixinInfo">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">微信头像</label>

                                <div class="col-sm-8">
                                    <img src="#" id="edit_avatar" width="50">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">性别</label>

                                <div class="col-sm-8">
                                    <label id="edit_gender" class="control-label"></label>
                                </div>
                            </div>
                        </div>

                    </div>

                </form>
            </div>

            <!--底部-->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

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

<!-- bootstrap-validator验证 -->
<script src="${ctx }/static/js/plugins/validator/js/bootstrapValidator.js"></script>
<script src="${ctx }/static/js/plugins/validator/js/language/zh_CN.js"></script>


<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 role.js -->
<script src="${ctx }/static/js/manage/menber.js?v=1.0.0"></script>

</body>

</html>

