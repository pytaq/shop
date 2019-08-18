/*查询数据库表结构的js*/
var proejctName="";
$(function(){

    proejctName=$("body").attr("data-project");

    $("#tb .rowdb").click(showTableDesc);

});

//显示表的详情
function showTableDesc(){
    console.log("ok");
    //得到表名
   var tableName= $(this).find("td").text();
   var dataBase=$("#databases").text();
   //ajax查询，返回html,要返js自己去拼
    $.ajax({
        type:"GET",
        url:proejctName+"/admin/manage/database/"+dataBase+"/"+tableName,
        dataType:"html",
        success:function(resp){
              $("#tableDescPanel").empty();//清空
             $("#tableDescPanel").append(resp);

             //置顶
            $("html,body").animate({scrollTop:"0px"}, 50);
        }
    });

}