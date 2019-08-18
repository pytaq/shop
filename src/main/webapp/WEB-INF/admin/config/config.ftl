<#assign ctx="${request.contextPath}">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/static/img/title.png"/>
    <title>惠特集</title>

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
    <!-- kindeditor -->
    <link href="${ctx }/static/js/plugins/kindeditor/themes/default/default.css" rel="stylesheet">

    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">

    <#--微调验证图标的位置-->
    <style>
        .form-control-feedback {
            right: -10px;
        }

    </style>
</head>


<body class="gray-bg" data-project="${ctx }">
<div class="wrapper wrapper-content animated fadeInRight">

    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading" style="text-align: center">
                    <h3 class="panel-title">商城基础配置</h3>
                </div>
            </div>
        </div>
    </div>

    <#--显示表单-->
    <form class="form-horizontal" id="editForm">
        <div class="row">
            <#--左侧小框-->
            <div class="col-md-4">
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">商城标题:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="title" name="title" class="form-control" value="${obj.title}">

                    </div>
                </div>


                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">商城地址:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="address" name="address" class="form-control" value="${obj.address}">

                    </div>
                </div>

                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">浏览器标题:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="webtitle" name="webtitle" class="form-control" value="${obj.webtitle}">

                    </div>


                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">商城邮箱:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="email" name="email" class="form-control" value="${obj.email}">

                    </div>
                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">商城关键字:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="keyword" name="keyword" class="form-control" value="${obj.keyword}">

                    </div>
                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">商城描述:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="description" name="description" class="form-control"
                               value="${obj.description}">

                    </div>
                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">商城电话:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="phone" name="phone" class="form-control" value="${obj.phone}">

                    </div>
                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4" style="text-align: right">
                        <label class="control-label">备案号:</label>
                    </div>

                    <div class="col-md-8">
                        <input type="text" id="icp" name="icp" class="form-control" value="${obj.icp}">

                    </div>
                </div>


            </div>

            <#--右侧大框-->
            <div class="col-md-8">
                <div class="row" style="margin-bottom: 5px">
                    <div class="col-md-3" style="text-align: right">
                        <label class="control-label">商城第三方统计代码:</label>
                    </div>

                    <div class="col-md-9">
                        <textarea id="tongjicode" name="tongjicode" class="form-control"
                                  style="resize:none;
                                  height: 100px;"
                        >
                            ${obj.tongjicode!}</textarea>
                    </div>
                </div>
                <div class="row" style="margin-bottom: 5px">
                    <div class="col-md-3" style="text-align: right">
                        <label class="control-label">商城第三方客服代码:</label>
                    </div>

                    <div class="col-md-9">
                        <textarea id="kfcode" name="kfcode" class="form-control"
                                  style="resize:none;
                                  height: 100px;"
                        >${obj.kfcode!}</textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3" style="text-align: right">
                        <label class="control-label">商城Logo:</label>
                    </div>

                    <div class="col-md-9">
                        <input type="hidden" id="logo" name="logo" class="form-control" value="${obj.logo!}">
                        <img src="${obj.logo!}" width="100" id="logoImg">
                        <button type="button" class="btn btn-success" id="btnChooseImage">上传图片</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-5" style="text-align: right">
                <button type="button" class="btn btn-primary  btn-lg" id="btnSave">保存</button>
            </div>
        </div>
    </form>

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

<!-- kindeditor -->
<script src="${ctx }/static/js/plugins/kindeditor/kindeditor-all.js"></script>
<script src="${ctx }/static/js/plugins/kindeditor/lang/zh-CN.js"></script>

<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 config.js -->
<script src="${ctx }/static/js/manage/config.js?v=1.0.0"></script>

</body>

</html>

