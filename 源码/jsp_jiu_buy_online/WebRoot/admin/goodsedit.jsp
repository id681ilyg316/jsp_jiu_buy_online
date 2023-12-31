<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="util.Info"%>
<%@page import="util.PageManager"%>
<%@page import="dao.CommDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
	<meta charset="utf-8">
    <title>后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%=basePath%>">
    <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">
    
	<link rel="stylesheet" type="text/css" href="/jiu_buy_online/admin/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/jiu_buy_online/admin/stylesheets/theme.css">
    <link rel="stylesheet" href="/jiu_buy_online/admin/lib/font-awesome/css/font-awesome.css">

    <script src="/jiu_buy_online/admin/lib/jquery-1.7.2.min.js" type="text/javascript"></script>

    <!-- Demo page code -->

    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .brand { font-family: georgia, serif; }
        .brand .first {
            color: #ccc;
            font-style: italic;
        }
        .brand .second {
            color: #fff;
            font-weight: bold;
        }
    </style>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">

	<script charset="utf-8" src="/jiu_buy_online/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/jiu_buy_online/kindeditor/lang/zh-CN.js"></script>
	<script>
	        KindEditor.ready(function(K) {
	                window.editor = K.create('#editor_id');
	        });
	</script>
	<script>

KindEditor.ready(function(K) {

K.create('textarea[name="note"]', {

uploadJson : '/jiu_buy_online/kindeditor/jsp/upload_json.jsp',

                fileManagerJson : '/jiu_buy_online/kindeditor/jsp/file_manager_json.jsp',

                allowFileManager : true,

                allowImageUpload : true, 

autoHeightMode : true,

afterCreate : function() {this.loadPlugin('autoheight');},

afterBlur : function(){ this.sync(); }  //Kindeditor下获取文本框信息

});

});

</script>
  </head>
  
  <body class="">
	<jsp:include page="/admin/top.jsp"></jsp:include>
    
    <jsp:include page="/admin/left.jsp"></jsp:include>
    
<%CommDAO dao = new CommDAO(); 
  String id = request.getParameter("id");
  HashMap map = dao.select("select * from goods where id="+id).get(0);
  %>
    
       <div class="content">
        
        <div class="header">
            
            <h1 class="page-title">商品编辑</h1>
        </div>
        
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">商品编辑</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">

<div class="well">
    <div id="myTabContent" class="tab-content">
      <div class="tab-pane active in" id="home">
		    <form id="form" action="/jiu_buy_online/jiu_buy_online?ac=goodsedit&id=<%=id %>" enctype="multipart/form-data">
		        <label>商品名称</label>
		        <input type="text" value="<%=map.get("goodname") %>" id="goodname" name="goodname" class="input-xlarge span5" required>
		        <label>商品分类</label>
		        			<select id="fid" name="fid" onChange="Change_Select()" class="input-xlarge" required>
								<option value="">请选择大类</option>
					    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
					    		for(HashMap fprotype:fprotypelist){%>
					    		<option value="<%=fprotype.get("id") %>" <%if(map.get("fid").equals(fprotype.get("id"))){out.print("selected==selected");}%>><%=fprotype.get("typename") %></option>
					    		<%} %>
							</select>
							<select id="sid" name="sid">
							    		<option value="">请选择</option>
							    		<%ArrayList<HashMap> sprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where  fatherid='"+map.get("fid")+"' "); 
							    		for(HashMap sprotype:sprotypelist){%>
							    		<option value="<%=sprotype.get("id") %>" <%if(map.get("sid").equals(sprotype.get("id"))){out.print("selected==selected");} %>><%=sprotype.get("typename") %></option>
							    		<%} %>
							</select>
				<label>商品品牌</label>
		        <select id="goodpp" name="goodpp" class="input-xlarge" required>
						<option value="">请选择品牌</option>
					    <%ArrayList<HashMap> pplist = (ArrayList<HashMap>)dao.select("select * from ppinfo where delstatus='0' "); 
					    for(HashMap ppmap:pplist){%>
					    <option value="<%=ppmap.get("id") %>" <%if(ppmap.get("id").equals(map.get("goodpp"))){out.print("selected==selected");} %>><%=ppmap.get("ppname") %></option>
					    <%} %>
				</select>
		        <label>商品价格</label>
		        <input type="number" value="<%=map.get("price") %>" step="0.1" id="price" name="price" class="input-xlarge" required>
		        <label>图片</label>
		        <input type="file" id="filename" name="filename" class="input-xlarge" >
		        <label>商品描述</label>
		        <textarea id="editor_id" id="note" name="note" style="width:1000px;height:400px;" ><%=map.get("note") %></textarea>
		        <button class="btn btn-primary"><i class="icon-save"></i> Save</button>
		    </form>
      </div>
  </div>

</div>

<div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Delete Confirmation</h3>
  </div>
  <div class="modal-body">
    
    <p class="error-text"><i class="icon-warning-sign modal-icon"></i>Are you sure you want to delete the user?</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
    <button class="btn btn-danger" data-dismiss="modal">Delete</button>
  </div>
</div>
            </div>
        </div>
    </div>

    <script src="/jiu_buy_online/admin/lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
    	
	
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });

        var req;
	    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
	      var fprotype = document.getElementById('fid').value;
	      var url = "/jiu_buy_online/jiu_buy_online?ac=searchsontype&fprotype="+ escape(fprotype);
	      if(window.XMLHttpRequest){
	        req = new XMLHttpRequest();
	      }else if(window.ActiveXObject){
	        req = new ActiveXObject("Microsoft.XMLHTTP");
	      }  
	      if(req){
	     
	        req.open("GET",url,true);
	         //指定回调函数为callback
	        req.onreadystatechange = callback;
	        req.send(null);
	      }
	    }
	    //回调函数
	    function callback(){
	    
	      if(req.readyState ==4){
	        if(req.status ==200){
	        //var msg = req.responseText;
			//		alert(msg);
	        
	          parseMessage();//解析XML文档
	        }else{
	          alert("不能得到描述信息:" + req.statusText);
	        }
	      }
	    }
	    //解析返回xml的方法
	    function parseMessage(){
	      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
	      var xSel = xmlDoc.getElementsByTagName('select');
	      //获得XML文档中的所有<select>标记
	      var select_root = document.getElementById('sid');
	      //获得网页中的第二个下拉框
	      select_root.options.length=0;
	      //每次获得新的数据的时候先把每二个下拉框架的长度清0
	     
	      for(var i=0;i<xSel.length;i++){
	        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
	        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
	        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
	        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
	       
	        var option = new Option(xText, xValue);
	        //根据每组value和text标记的值创建一个option对象
	       
	        try{
	          select_root.add(option);//将option对象添加到第二个下拉框中
	        }catch(e){
	        }
	      }
	    }  
    </script>
  </body>
</html>
