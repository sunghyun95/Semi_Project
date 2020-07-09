<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#webhardlist th,#webhardlist td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  #webh{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #005000;
}
#webhr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #005000, #f0f0f0);
    margin-bottom: 2%;
}
#insert{
float: right;
   margin-right: 2%;
   font-size: 15pt;
   color: #005000;
   cursor: pointer;
}
</style>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<%
   String root = request.getContextPath();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<script type="text/javascript">
var startPage = "";
var endPage = "";
var totalPage = "";
var currentPage = "";
var pageNum = "";
var sort = "";
$(function(){
   
   list(1,null,null,null,pageNum);   
   
   
   
   $("#srchBtn").click(function(){
      
      pageNum = 1;
      var searchtxt = $("#searchtxt").val();
      var category = $("#category").val();
      
      list(1,category,searchtxt,null,pageNum);
      sort ="";
   });
   
   $("#cntBtn").click(function(){
      pageNum = 1;   
      sort = $(this).val();
      
      if($("#searchtxt").val().length != null){
         var searchtxt = $("#searchtxt").val();
         var category = $("#category").val();
         list(1,category,searchtxt,sort,pageNum);
         
      }else{
         list(1,null,null,sort,pageNum);
      }
   });

   $("#likeBtn").click(function(){
      pageNum = 1;
      sort = $(this).val();
      
      if($("#searchtxt").val != null||$("#searchtxt")!=""){
      
      var category = $("#category").val();
      var searchtxt = $("#searchtxt").val();
      
      list(1,category,searchtxt,sort,pageNum);
      
      }else{
         list(1,null,null,sort,pageNum);
      }
   });
   
   $(document).on("click","span.pagebtn",function(){
         pageNum = $(this).attr("pageNum");
         //alert(pageNum);
         //alert($("#searchtxt").val());
         //alert(sort);
      
         if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
            
            if(sort==""||sort.length==0||sort==null){
               pageNum = $(this).attr("pageNum");
            list(1,null,null,null,pageNum);                  
            
            }else{
               pageNum = $(this).attr("pageNum");
               
            
               list(1,null,null,sort,pageNum);
            }
            
            
         }else{
            if(sort==""||sort.length==0||sort==null){
               var searchtxt = $("#searchtxt").val();
               var category = $("#category").val();
               
               list(1,category,searchtxt,null,pageNum);                  
               
            }else{
               var searchtxt = $("#searchtxt").val();
               var category = $("#category").val();
                
               list(1,category,searchtxt,sort,pageNum);
               }
         }      
         
   });
   
   
});
   
function list(bopen,category,searchtxt,sort,pageNum){
   
   $.ajax({
      type:"post",
      url:"webhard/webhard_private_listaction.jsp",
      dataType:"json",
      data:{"bopen":bopen,"category":category,"searchtxt":searchtxt,"sort":sort,"pageNum":pageNum},
      success:function(data){
         
         var str = "<table id='webhardlist' style='width:100%; width: 100%; border-top: 1px solid #444444; border-collapse: collapse;'>";
         
         str+="<tr>";
         
         str+="<th style='width:10%;'>번호</th>";
         str+="<th style='width:55%; text-align:center;'>제목</th>";
         str+="<th style='width:25%; text-align:center;'>작성일</th>";
         str+="</tr>";
         if(data.length==0){
             str+="<tr><th colspan='6'>게시글이 존재하지 않습니다</th></tr>"
          
          }else{
    $.each(data, function(i, item){
       
       currentPage = item.currentPage;
       endPage = item.endPage;
       startPage = item.startPage;
       totalPage = item.totalPage;
       pageNum = item.pageNum;
       
       
       
       str+= "<tr>";
       str+="<td style='text-align:center;'>"+(i+1)+"</td>";
       str+="<td><a href='<%=root%>/startmain.jsp?content=webhard/webhard_getData.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"' style='color:black;'>"+item.subject+"</a></td>";
      
       str+="<td style='text-align:center;'>"+item.writeday+"</td>";
       str+="</tr>";
       
    });
          }
         
         
         str += "</table>";
         
         
         $("#tablelist").html(str);
         
         
         
         paging(pageNum,startPage,endPage,totalPage,currentPage);
         
         
         
         
      },
      error:function(data){
         console.log("error:function");
         console.log(data);
      }
      
   });   
      
}

function paging(pageNum,startPage,endPage,totalPage,currentPage){
   var pg = "";
   pg += "<ul style='text-align:center;'>";

   if(startPage > 1){
      
      pg+="<a href='#' style='color:black'><span class='pagebtn' pageNum='"+(startPage-1)+"'>BACK</span></a>";
      
   }
   
   for(var i=startPage; i<=endPage; i++){
      
      if(i==currentPage){
      pg+="<a href='#' style='font-size:15pt; color:black;'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
      
          
      }else{
         pg+="<a href='#' style='color:black'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
         
      }
      
   }
   
   if(endPage < totalPage){
      pg+="<a href='#'><span class='pagebtn' pageNum='"+(endPage+1)+"'>NEXT</span></a>";
      
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}
</script>
</head>
<body>
<div style="width:100%;">
	<div style="width:70%;">
	
<h1 id="webh">WEBHARD_<span style="font-size: 13pt;">PRIVATE FOLDER</span></h1>
<span id="insert" onclick="location.href='<%=root%>/startmain.jsp?content=webhard/webhard_insertform.jsp?webhard=1'">INSERT</span>
<br><br>
<hr id="webhr">
<button type="button" style="float:right;" id="srchBtn">SEARCH</button>
<input type="text" style="float:right; margin-right: 1%; width:300px" id="searchtxt">
<select id="category" style="float:right; margin-right: 1%;">
   <option value="bsubject">제목</option>
   <option value="bcontent">내용</option>
</select>
<div id="tablelist"></div>
<div id="paging">
</div>
 </div>
 </div>
</body>
</html>