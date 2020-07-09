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
}

div.gallery {
  margin: 5px;
  border: 1px solid #ccc;
  float: left;
  width: 180px;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 100%;
  height: auto;
}

div.desc {
  padding: 15px;
  text-align: center;
}
</style>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<%
   String root = request.getContextPath();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   String pageNum = request.getParameter("pageNum");
   String num = (String)session.getAttribute("num");
%>
<script type="text/javascript">
var startPage = "";
var endPage = "";
var totalPage = "";
var currentPage = "";
var pageNum = <%=pageNum%>;
var sort = "";
$(function(){
   
   list(0,null,null,null,pageNum);   
   
   
   
   $("#srchBtn").click(function(){
      
      pageNum = 1;
      var searchtxt = $("#searchtxt").val();
      var category = $("#category").val();
      
      list(0,category,searchtxt,null,pageNum);
      sort ="";
   });
   
   $("#cntBtn").click(function(){
      pageNum = 1;   
      sort = $(this).val();
      
      if($("#searchtxt").val()!=""){
         var searchtxt = $("#searchtxt").val();
         var category = $("#category").val();
         list(0,category,searchtxt,sort,pageNum);
         
      }else{
         list(0,null,null,sort,pageNum);
      }
   });

   $("#likeBtn").click(function(){
     
      pageNum = 1;
      sort = $(this).val();
	  searchvalue=$("#searchtxt").val();
     if(searchvalue!=""){
      var category = $("#category").val();
      var searchtxt = $("#searchtxt").val();
      pageNum = 1;
      sort = $(this).val();
      list(0,category,searchtxt,sort,pageNum);
      
      }else{
    	  pageNum = 1;
          sort = $(this).val();
         list(0,null,null,sort,pageNum);
      }
   });
   
   $(document).on("click","span.pagebtn",function(){
         pageNum = $(this).attr("pageNum");
      //   alert($("#searchtxt").val());
      //   alert(sort);
      
         if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
            
            if(sort==""||sort.length==0||sort==null){
               pageNum = $(this).attr("pageNum");
            list(0,null,null,null,pageNum);                  
            
            }else{
               pageNum = $(this).attr("pageNum");
               
            
               list(0,null,null,sort,pageNum);
            }
            
            
         }else{
            if(sort==""||sort.length==0||sort==null){
               var searchtxt = $("#searchtxt").val();
               var category = $("#category").val();
               alert("sort null="+pageNum);
              alert(category+","+searchtxt+","+sort+","+pageNum);
               list(0,category,searchtxt,null,pageNum);                  
               
            }else{
               var searchtxt = $("#searchtxt").val();
               var category = $("#category").val();
                alert("all not null="+pageNum);
                  alert(category+","+searchtxt+","+sort+","+pageNum);
               list(0,category,searchtxt,sort,pageNum);
               }
         }      
         
   });
   
   $(document).on("click","a.sendMessage",function(){
      var writernum = $(this).attr("writernum");
      window.open("message/sendMessage.jsp?writernum="+writernum,"","width=600px,height=365px,left=600px,top=100px");
   });
   
});
   
function list(bopen,category,searchtxt,sort,pageNum){
   
   $.ajax({
      type:"post",
      url:"webhard/webhard_publicListaction.jsp",
      dataType:"json",
      data:{"bopen":bopen,"category":category,"searchtxt":searchtxt,"sort":sort,"pageNum":pageNum},
      success:function(data){
         
         var str = "<table id='webhardlist' style='width:100%; width: 100%; border-top: 1px solid #444444; border-collapse: collapse;'>";
         
         str+="<tr>";
         
         str+="<th style='width:5%;'>번호</th>";
         str+="<th style='width:55%; text-align:center;'>제목</th>";
         str+="<th style='width:15%; text-align:center;'>작성자</th>";
         str+="<th style='width:15%; text-align:center;'>작성일</th>";
         str+="<th style='width:5%; text-align:center;'>조회수</th>";
         str+="<th style='width:5%; text-align:center;'><img src='image/redheart.png' style='width:15px; height:15px'></th>";
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
       
       //if(item.flistcount > 0){
    //	   str+="<td><img src='image/folderfill.png' style='width:70px; height:70px;'></td>";
     //  }else{
    	//   str+="<td><img src='image/folderempty.png' style='width:70px; height:70px;'></td>";
      // }
       
       str+="<td><a href='<%=root%>/startmain.jsp?content=webhard/webhard_getData.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"' style='color:black'>"+item.subject+"</a></td>";
       if(<%=num%>!=item.writernum){
       str+="<td style='text-align:center;'><a href='#' style='color:black' class='sendMessage' writernum='"+item.writernum+"'>"+item.writer+"</a></td>";    	   
       }else{
    	   str+="<td style='text-align:center;'>"+item.writer+"</td>";
       }
       str+="<td style='text-align:center;'>"+item.writeday+"</td>";
       str+="<td style='text-align:center;'>"+item.readcount+"</td>";
       str+="<td style='text-align:center;'>"+item.likes+"</td>";
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
         pg+="<a href='#'  style='color:black'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
         
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
	
<h1 id="webh">WEBHARD_<span style="font-size: 13pt;">PUBLIC FOLDER</span></h1>
<span id="insert" onclick="location.href='<%=root%>/startmain.jsp?content=webhard/webhard_insertform.jsp?webhard=2'">INSERT</span>
<br><br>
<hr id="webhr">

<button id="cntBtn" value="breadcount" style="float:left; margin-right: 1%; margin-bottom: 1%">SORT COUNT</button>
<button type="button" id="likeBtn" class="likeBtn" value="blike" style="float:left;">SORT LIKES</button>
<button type="button" style="float:right;" id="srchBtn">SEARCH</button>
<input type="text" style="float:right; margin-right: 1%; width:300px" id="searchtxt" required="required">
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