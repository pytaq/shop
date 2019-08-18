/**
 * bootstrap-table加载数据
 */

//全局变量
var $tb;
var projectName=''; //得到项目名称
var filePath='';   //要修改的文件路径

$(function(){
	
	$tb=$("#tb");
	//得到项目名称
	projectName=$.trim($("body").attr("data-project"));	
	
	//初始化配置信息
    initTable();	
    
    //按钮初始化事件
    initButtonHandler();

});


function initButtonHandler(){
   //保存
	$("#btnSave").click(contentSave);
}

function initTable(){
	
	var projectName=$.trim($("body").attr("data-project"));

	$.ajax({
		type:"POST",
		url:projectName+"/admin/manage/template/allfile",
		dataType:"json",
		success:function(resp){
          //http://www.jq22.com/demo/bootstrap-treeview20161102/

            $('#tree').treeview({
                color: "#428bca",
                expandIcon: 'glyphicon glyphicon-chevron-right',   //文件夹展开的图标
                collapseIcon: 'glyphicon glyphicon-chevron-down',   //文件夹折叠的图标
                nodeIcon: 'glyphicon glyphicon-book',             //文件的图标
                data: resp,
				//https://www.cnblogs.com/tangzeqi/p/8021637.html
                onNodeSelected: function(event, node) {
                    console.log(node);
                    //读取文件原码
                    if(node.fileType==2){
                       filePath=node.fileAbstractAddress;
                       filePath=encodeURIComponent(filePath);
                       //替换特殊符号
                       $.ajax({
						   type:"POST",
						   url:projectName+"/admin/manage/template/source",
						   data:{"filePath":filePath},
						   dataType:"html",
						   success:function(respCode){
						   	   $("#tmpArea").val(respCode);
						   }
					   });
					}else{
                    	filePath='';
                        $("#tmpArea").val('');
					}

                }

            });

		}
	});


}        

//内容保存
function contentSave(){

	if(filePath==''){
		return;
	}

    $.ajax({
        type:"POST",
        url:projectName+"/admin/manage/template/save",
        data:{"filePath":filePath,'content':$("#tmpArea").val() },
        dataType:"json",
        success:function(resp){
            console.log(resp);
        }
    });
}



