<#assign ctx="${request.contextPath}">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品信息新增</title>


    <link href="${ctx }/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx }/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx }/static/css/animate.css" rel="stylesheet">

    <!-- kineditor样式-->
    <link href="${ctx }/static/js/plugins/kindeditor/themes/default/default.css" rel="stylesheet">

    <!-- bootstrap-validator验证 -->
    <link href="${ctx }/static/js/plugins/validator/css/bootstrapValidator.css" rel="stylesheet">

    <link href="${ctx }/static/css/style.css?v=4.1.0" rel="stylesheet">


</head>
<body    data-project="${ctx }"  >

<div class="form1">
    <form class="form-horizontal"  id="addform" method="post"  action="">
        <div  data-example-id="togglable-tabs" style="min-height: 600px;">

            <ul id="myTabs" class="nav nav-tabs" role="tablist"   >
                <li role="presentation" class="active">
                    <a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">基本信息</a>
                </li>
                <li role="presentation" class="">
                    <a href="#imgs" role="tab" id="imgs-tab" data-toggle="tab" aria-controls="imgs" aria-expanded="false">图片库</a>
                </li>
                <li role="presentation" class="">
                    <a href="#details" role="tab" id="details-tab" data-toggle="tab" aria-controls="details" aria-expanded="false">商品详情信息</a>
                </li>

            </ul>
            <div id="myTabContent" class="tab-content" style="padding-top:20px;">
                <!--商品基本信息-->
                <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
                    <div class="form-group">
                        <div class="col-md-4">
                            <label class="col-sm-2 control-label">一级分类</label>
                            <div class="col-sm-10">
                                <select  id="firstCate" name="pcate" class="form-control">
                                    <#list   first as f>
                                        <option value="${f.id}">${f.name}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="col-sm-2 control-label">二级分类</label>
                            <div class="col-sm-10">
                                <select  id="secondCate" name="ccate" class="form-control">
                                    <#list   second as f>
                                        <option value="${f.id}">${f.name}</option>
                                    </#list>
                                </select>
                            </div>

                        </div>

                        <div class="col-md-4">
                            <label class="col-sm-2 control-label">三级分类</label>
                            <div class="col-sm-10">
                                <select  id="thirdCate" name="tcate" class="form-control">
                                    <#list   third as f>
                                        <option value="${f.id}">${f.name}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品名称</label>
                            <div class="col-sm-10">
                                 <input type="text" class="form-control" name="title" id="title"   placeholder="商品名称">
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品描述</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="description" name="description" placeholder="简单描述">
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品货号</label>
                            <div class="col-sm-10">
                            <input type="text" class="form-control" name="goodssn" id="goodssn"  placeholder="商品货号">
                                </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品名称</label>
                            <div class="col-sm-10">
                            <input type="text" class="form-control" name="title" id="title"   placeholder="商品名称">
                                </div>
                        </div>

                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品描述</label>
                            <div class="col-sm-10">
                            <input type="text" class="form-control" id="description" name="description" placeholder="简单描述">
                                </div>
                        </div>

                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品货号</label>
                            <div class="col-sm-10">
                            <input type="text" class="form-control" name="goodssn" id="goodssn"  placeholder="商品货号">
                                </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品特性</label>
                            <div class="col-sm-10">
                                <input type="checkbox"   name="isnew" id="isnew" >新品
                                <input type="checkbox"  name="ishot" id="ishot" >热卖
                                <input type="checkbox"   name="isdiscount" id="isdiscount" >打折
                                <input type="checkbox"   name="isrecommand" id="isrecommand" >首页推荐
                                <input type="checkbox"   name="issendfree" id="issendfree" >免邮费
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-4">
                            <label   class="col-sm-2 control-label">商品重量</label>
                            <div class="col-sm-10">
                            <input type="number" class="form-control"  min="0"  step="0.01" name="weight" id="weight" placeholder="商品重量">
                                </div>
                        </div>

                        <div class="col-sm-4">
                            <label   class="col-sm-2 control-label">商品条码</label>
                            <div class="col-sm-10">
                            <input type="text" name="productsn" class="form-control" id="productsn"   placeholder="商品条码">
                                </div>
                        </div>


                        <div class="col-sm-4">
                            <label  class="col-sm-2 control-label">商品库存</label>
                            <div class="col-sm-10">
                            <input type="number" class="form-control"  name="total" min="0" id="total"   placeholder="库存">
                                </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-4">
                            <label class="col-sm-2 control-label">本店售价</label>
                            <div class="col-sm-10">
                            <input type="number" name="marketprice" class="form-control" step="0.01" id="marketprice"  placeholder="售价">
                                </div>
                        </div>

                        <div class="col-sm-4">
                            <label   class="col-sm-2 control-label">市场售价</label>
                            <div class="col-sm-10">
                            <input type="number" min="0"   class="form-control" name="productprice"  id="productprice" placeholder="市场售价">
                                </div>
                        </div>


                        <div class="col-sm-4">
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-sm-4">
                            <label class="col-sm-2 control-label">限时促销</label>
                            <div class="col-sm-10">
                                <input type="checkbox" id="istime" name="istime"   value="1">
                            </div>
                        </div>

                        <div class="col-sm-6" id="time">
                            <label   class=" control-label">开始时间</label>
                            <input type="text" min="0"   name="timestart"  id="timestart" placeholder="促销开始时间">
                            <label   class=" control-label">结束时间</label>
                            <input type="text" min="0"     name="timeend"  id="timeend" placeholder="促销结束售价">
                        </div>

                    </div>


                </div>


                <!--商品图片库-->
                <div role="tabpanel" class="tab-pane fade" id="imgs" aria-labelledby="imgs-tab">
                    <div class="form-group">
                        <button  class="btn btn-primary"  type="button" id="btnUploads">批量上传图片</button>
                    </div>

                    <div class="form-group" id="prevImage">

                    </div>
                </div>

                <!-- 商品详情-->
                <div role="tabpanel" class="tab-pane fade" id="details" aria-labelledby="details-tab">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea id="content" name="content" class="form-control" style="width:100%;height:500px;visibility:hidden;"></textarea>
                        </div>
                    </div>
                </div>

            </div>
        </div>

         <div class="row">
             <button class="btn btn-success" id="btnSave">保存产品</button>
         </div>
    </form>

</div>





<!-- 全局js -->
<script src="${ctx }/static/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx }/static/js/bootstrap.min.js?v=3.3.6"></script>

<!-- Peity -->
<script src="${ctx }/static/js/plugins/peity/jquery.peity.min.js"></script>

<!-- bootstrap-validator验证 -->
<script src="${ctx }/static/js/plugins/validator/js/bootstrapValidator.js"></script>
<script src="${ctx }/static/js/plugins/validator/js/language/zh_CN.js"></script>

<!-- kineditor-->
<script src="${ctx }/static/js/plugins/kindeditor/kindeditor-all.js"></script>
<script src="${ctx }/static/js/plugins/kindeditor/lang/zh-CN.js"></script>

<!-- 自定义js -->
<script src="${ctx }/static/js/content.js?v=1.0.0"></script>

<!-- 自定义 user.js -->
<script src="${ctx }/static/js/manage/addshopgoods.js?v=1.0.0"></script>

</body>
</html>