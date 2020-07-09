<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title>Insert title here</title>
</head>
<%
   request.setCharacterEncoding("UTF-8");
   String pageNum = request.getParameter("pageNum");
   String num = (String)session.getAttribute("num");
   MemberDao mdao = new MemberDao();
   MemberDto mdto = mdao.getMember(num);
%>


<style type="text/css">

   #noticetable th, #noticetable td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  #notihr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #000054, #f0f0f0);
    margin-bottom: 2%;
}
#noti{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #000054;
}
#insert{
   float: right;
   margin-right: 2%;
   font-size: 15pt;
   color: #000054;
   
}
</style>
<script type="text/javascript">
var startPage = "";
var endPage = "";
var totalPage = "";
var currentPage = "";
var pageNum = "<%=pageNum%>";
$(function(){
   list(null,null,pageNum);
   
   $("#srchBtn").click(function(){
      
      pageNum = 1;
      var searchtxt = $("#searchtxt").val();
      var category = $("#category").val();
     
      list(category,searchtxt,pageNum);
   });
   
   $(document).on("click","span.pagebtn",function(){
      pageNum = $(this).attr("pageNum");
    //   alert(pageNum);
    //   alert($("#searchtxt").val()); 
   
      if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
         
         pageNum = $(this).attr("pageNum");
         //alert("searchtxt null"+pageNum);
         list(null,null,pageNum);                  
      
      }else{//검색어가 있을때
            var searchtxt = $("#searchtxt").val();
            var category = $("#category").val();
            pageNum = $(this).attr("pageNum");
            /* alert("sort null="+pageNum);
            alert(category+","+searchtxt+","+pageNum); */
            list(category,searchtxt,pageNum);                  
            
      }      
      
});
   $(document).on("click","a.sendMessage",function(){
      var writernum = $(this).attr("writernum");
      window.open("message/sendMessage.jsp?writernum="+writernum,"","width=600px,height=365px,left=600px,top=100px");
   });
   
});
function list(category,searchtxt,pageNum){
   $.ajax({
      type:"get",
      url:"notice/noticeDb.jsp",
      dataType:"json",
      data:{"category":category,"searchtxt":searchtxt,"pageNum":pageNum},
      success:function(data){
         var str="";
         if(data.length==0){
             str+="<tr><th colspan='6'>게시글이 존재하지 않습니다</th></tr>"
          
          }else{
         $.each(data,function(i,item){
            
            startPage = item.startPage;
            endPage = item.endPage;
            totalPage = item.totalPage;
            currentPage = item.currentPage;
            pageNum = item.pageNum;
            
            
            str+="<tr>";
            str+="<td>"+(i+1)+"</td>";
            if(item.bnotice == 1){
               
            str+="<td align='left'>"+"<b style='color:red;'>[공지]</b><a href='startmain.jsp?content=notice/notice_content.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"' style='color:black;'>"+item.bsubject+"</a></td>";
            }else{
               str+="<td align='left'>"+"<a href='startmain.jsp?content=notice/notice_content.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"'style='color:black;'>"+item.bsubject+"</a></td>";
                  
            }
            str+="<td>"+item.bwriter+"</td>";
            str+="<td>"+item.bwriteday+"</td>";
            str+="<td>"+item.breadcount+"</td>";
            str+="</tr>";
            
         })
          }
         $("#noticelist").html(str);
         
         paging(pageNum,startPage,endPage,totalPage,currentPage);
         
         
      },
      error:function(data){
         console.log("error:function")
         console.log(data);
      }
   })
}

function paging(pageNum,startPage,endPage,totalPage,currentPage){
   var pg = "";
   pg += "<ul style='text-align:center;'>";

   if(startPage > 1){
      
      pg+="<a href='#' style='color:black'><span class='pagebtn' pageNum='"+(startPage-1)+"'>BACK</span></a>";
      
   }
   
   for(var i=startPage; i<=endPage; i++){
      
      if(i==currentPage){
      pg+="<a href='#' style='font-size:15pt; color:black'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
      
          
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
<%
   String root=request.getContextPath();
%>
<body>
<div style=" width: 100%">
	<div style="width: 70%;">
	

<h1  id="noti">NOTICE</h1>
	<%if(mdto.getBuseo().equals("관리자")) {%>
   <a href="startmain.jsp?content=notice/noticeaddform.jsp" id="insert">INSERT</a><br><br>	
	<%}%>
   <hr id="notihr">
<button type="button" style="float:right; margin-bottom: 2%; " id="srchBtn">SEARCH</button>
<input type="text" style="float:right; margin-right: 1%; width:300px" id="searchtxt" required="required">
<select id="category" style="float:right; margin-right: 1%">
   <option value="bsubject">제목</option>
   <option value="bcontent">내용</option>
</select>
<table id="noticetable" style='width:100%; width: 100%; border-top: 1px solid #444444; border-collapse: collapse;'>
<thead>
   <tr>
      <th style="width:5%; text-align:center;">번호</th>
      <th style="width:40%; text-align:center;">제목</th>
      <th style="width:20%; text-align:center;">작성자</th>
      <th style="width:10%; text-align:center;">작성일</th>
      <th style="width:5%; text-align:center;">조회수</th>
   </tr>
   </thead>
   <tbody id="noticelist" style="text-align: center">
   </tbody>
</table>
<div id="paging" style="align:center; color:black"></div>

	</div>
</div>
</body>
</html>