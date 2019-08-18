/**
 * 
 */
var projectName=''; //得到项目名称
 
 
//这一个试题
var questionObj={
		questionNameEditor:null,   //题目 
		analyze:null,             //试题解析
		questionArr:[]           //动态项目
};    


$(function(){
	//得到项目名称
	projectName=$.trim($("body").attr("data-project"));	
	
	//初始化icheck样式
	initICheck();
	
	//初始化kindeditor富文本框
	initEditor();
	
	$("#btnVALUE").click(function(){
		
		var v1=questionObj.questionNameEditor.html();
		console.log("题目的内容是：");
		console.log(v1);
		
		//试题解析
		var v2=questionObj.analyze.html();
		console.log("试题解析的内容是：");
		console.log(v2);
		
		//选项目
	   for(var i=0;i<questionObj.questionArr.length;i++){
		   var v3=questionObj.questionArr[i].html();
			console.log("选项"+(i+1));
			console.log(v3);
	   } 
		
	});
	
	//试题数量更改
	$("#questionNum").change(questionNumChange);
	
});

function questionNumChange(){
	let value=parseInt($(this).val());  //4,5,6
	//得到原来的试题数量
	let oldCount=questionObj.questionArr.length;
	 
	if(oldCount >value ){
		//减少试题要删除，得到要减少几个,从最后面开始删除
		let diff=oldCount-value;
		//再移出  questionObj.questionArr[下标]
		questionObj.questionArr=questionObj.questionArr.slice(0,oldCount-diff);
		
		for(let i=0;i<diff;i++){ 
			//先要移出 dom节点
			 $(".chooseInfo .form-group:last").remove();
		}
		
	}else if(oldCount< value){
		//增加试题
		let diff=value-oldCount;
		for(let i=0;i<diff;i++){
			//复制最后一个节点
			let cloneDom=$(".chooseInfo .form-group:last").clone(false);
			//更改label的值
			let letter=String.fromCharCode(69+i);
			//更改cloneDom节点里面的label标签
			cloneDom.find("label").html("选项"+letter);
			
			//移除掉建立好的富文本样式
			cloneDom.find("div.ke-container").remove();
			
			//更改cloneDom节点时面的textarea的id和name
			let area=cloneDom.find("textarea");
			let indexId=5+i;
			area.attr("id","answer"+indexId);
			area.attr("name","answer"+indexId);
			
			//追加到chooseInfo里面
			$(".chooseInfo").append(cloneDom);
			 
			//console.log(cloneDom[0].outerHTML);
			//调用kindEditor创建方法 ,添加到 questionObj.questionArr
			createEditor("textarea[name='answer"+indexId+"']","questionObj.questionArr",indexId-1);
			 
		}
	}
	
}

//初始化单选或多选按钮  https://www.bootcss.com/p/icheck/
function initICheck(){
	  $('.icheckRadio').iCheck({
		    checkboxClass: 'icheckbox_flat-blue',
		    radioClass: 'iradio_flat-blue'
	 });
}


function initEditor(){
	//创建试题问题editor
	createEditor("textarea[name='questionName']","questionNameEditor");
	
	 //第一个editor 
	let num=$("#questionNum").val() || 4;
	for(let i=0;i<num;i++){
		createEditor("textarea[name='answer"+(i+1)+"']","questionObj.questionArr",i);
	}
//	createEditor("textarea[name='answer1']","questionObj.questionArr",0);
//	createEditor("textarea[name='answer2']","questionObj.questionArr",1);
//	createEditor("textarea[name='answer3']","questionObj.questionArr",2);
//	createEditor("textarea[name='answer4']","questionObj.questionArr",3)
	
	createEditor("textarea[name='analyze']","analyze")
}


function createEditor(selection,varName){
	
	let index=arguments[2];  	 
	var editor;
	
	 //异步创建
     KindEditor.ready(function(K) { 
		
    	 editor = K.create(selection, { 
			uploadJson : projectName+'/statis/js/plugins/kindeditor/jsp/upload_json.jsp',   //文件上传的地址
			fileManagerJson :projectName+'/statis/js/plugins/kindeditor/jsp/file_manager_json.jsp',  //文件浏览地址
			allowFileManager : true,     //是否允许管理服务器上面的文件			
		});
		  
    	 //把对象引用到另外一地址上
    	 if(varName.startsWith("questionObj.questionArr")){
    		  
    		 questionObj.questionArr[index]=editor;
    		 
    	 }else{ 
    	    questionObj[varName]=editor;
    	 }
	}); 
	  
}

