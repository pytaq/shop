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

    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg" data-project="${ctx }">


<div class="wrapper wrapper-content animated fadeInRight">

    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-4">

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">数据库名: <span id="databases">${databaseName!''}</span>(点击查询详情)</h3>

                </div>
                <div class="panel-body">
                    <table id="tb" class="table table-bordered">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>表名</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list dbTables as b>
                            <tr class="rowdb">
                                <th scope="row">${b_index+1}</th>
                                <td>${b}</td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>

                </div>
            </div>

        </div>

        <div class="col-md-8">

            <div class="panel panel-info" id="tableDescPanel">

           </div>


        </div>
    </div>


</div>


<!-- 全局js -->
<script src="${ctx }/static/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx }/static/js/bootstrap.min.js?v=3.3.6"></script>

<!-- Peity -->
<script src="${ctx }/static/js/plugins/peity/jquery.peity.min.js"></script>

<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>
<script src="${ctx }/static/js/manage/db.js?v=1.0.0"></script>

</body>

</html>
