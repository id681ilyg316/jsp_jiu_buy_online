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

	
  </head>
  
  <body class="">
    
    <%	 CommDAO dao = new CommDAO(); 
	 String sql = "select * from protype where 1=1 and delstatus='0' and fatherid='0' ";
	 String url = "/jiu_buy_online/admin/protype.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 if(f==null)
	 {
	 key = Info.getUTFStr(key);
	 }
	 if(!key.equals(""))
	 {
	 sql+=" and (typename like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>

	<jsp:include page="/admin/top.jsp"></jsp:include>
    
    <jsp:include page="/admin/left.jsp"></jsp:include>
    

    
       <div class="content">
        
        <div class="header">
            
            <h1 class="page-title">商品类别</h1>
        </div>
        
                <ul class="breadcrumb">
            <li><a href="admin/index.jsp">Home</a> <span class="divider">/</span></li>
            <li class="active">商品类别</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
            <%String suc = (String)request.getAttribute("suc");
			if(suc!=null){%>
			    <div class="alert alert-info">
			        <button type="button" class="close" data-dismiss="alert">×</button>
			        	<%=suc %>
			        	<script type="text/javascript">
			        		location.href="admin/protype.jsp";
			        	</script>
		    	</div>
			<%}%>
				<div class="btn-toolbar">
					<div class="search-well">
						<form action="admin/protype.jsp?f=f" class="form-inline">
							<input class="input-xlarge" placeholder="类别名称..." id="key" name="key" type="text" value="<%=key %>">
		                    <button class="btn" type="submit"><i class="icon-search"></i> Go</button>
						    <button class="btn btn-primary" onclick="protypeadd(0)" type="button"><i class="icon-plus"></i> 大类</button>
						</form>	
					</div>  	
				</div>
			
<div class="well">
    <table class="table">
      <thead>
        <tr>
          <th>大类名称</th>
          <th>小类</th>
        </tr>
      </thead>
      <tbody>
      <%String did = request.getParameter("did");
   if(did!=null)
   {
	   dao.commOper("update protype set delstatus='1' where id="+did);
   }
   PageManager pageManager = PageManager.getPage(url,10, request);
   pageManager.doList(sql);
   PageManager bean= (PageManager)request.getAttribute("page");
   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
   	for(HashMap map:list){
	    %>
        <tr>
          <td><%=map.get("typename") %>
          [<a href="admin/protypeedit.jsp?id=<%=map.get("id") %>"><i class="icon-pencil"></i></a>
		    &nbsp;
		    <a href="admin/protype.jsp?did=<%=map.get("id") %>" ><i class="icon-remove"></i></a>
		    ]
          </td>
          <td>
          	<a href="admin/protypeadd.jsp?fatherid=<%=map.get("id") %>"><i class="icon-plus"></i></a>
		    &nbsp;&nbsp;
		    <%ArrayList<HashMap> sonlist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid="+map.get("id")); 
		    for(HashMap sonmap:sonlist){%>
		    <%=sonmap.get("typename") %> 
		    [<a href="admin/protypeedit.jsp?id=<%=sonmap.get("id") %>"><i class="icon-pencil"></i></a>
		    &nbsp;
		    <a href="admin/protype.jsp?did=<%=sonmap.get("id") %>" ><i class="icon-remove"></i></a>
		    ]
		    &nbsp;&nbsp;&nbsp;
		    <%} %>
          </td>
          
        </tr>
        <%} %>
      </tbody>
    </table>
</div>
<div class="pagination">
    ${page.info }
</div>

    <script src="/jiu_buy_online/admin/lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
    	function protypeadd(fatherid){
			location.href="admin/protypeadd.jsp?fatherid=0";
        }
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
  </body>
</html>
