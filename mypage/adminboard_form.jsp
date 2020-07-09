
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
<style type="text/css">
#boardlist{
   width:100%;
    margin-bottom: 2%;"
}
#boardlist th, #boardlist td{
   border-bottom:1px solid black;
    padding: 10px;
    text-align:center;
}
#settinghr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    margin-bottom: 2%;
    margin-top: 3%;
}
#setting{
font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #8C8C8C;
}
#insert{
   float: right;
   margin-right: 2%;
   font-size: 15pt;
   color: #8C8C8C;
   padding-top: 3%;
   
}
</style>
</head>
<%
   String num=request.getParameter("num");
   String bnum=request.getParameter("bnum");
   String pageNum = request.getParameter("pageNum");
%>
<%
   String root=request.getContextPath();
%>
<body>
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
        
      alert(category+","+searchtxt+","+pageNum);
         
         list(category,searchtxt,pageNum);
      });
 
    $(document).on("click","span.pagebtn",function(){
      pageNum = $(this).attr("pageNum");
      
      
      if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
         
         pageNum = $(this).attr("pageNum");
         //alert("searchtxt null"+pageNum);
         list(null,null,pageNum);                  
      
      }else{//검색어가 있을때
            alert("검색어가 있을때");
            var searchtxt = $("#searchtxt").val();
            var category = $("#category").val();
            pageNum = $(this).attr("pageNum");
            
            /*alert("sort null="+pageNum);
            alert(category+","+searchtxt+","+pageNum);*/
            list(category,searchtxt,pageNum);                  
            
      }      
      
});
});
function list(category, searchtxt, pageNum){
   var type="";
   var subject = "";
   $.ajax({
      type:"post",
      url:"mypage/adminboard_action.jsp",
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
            
               if(item.boardtype==1){
                   type="<span style='color:#000054;'>NOTICE</span>";
                   subject="<a style='color:black' href='startmain.jsp?content=notice/notice_content.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"&mypage=2'>"+item.bsubject+"</a>";
                }else if(item.boardtype==5){
                   type="<span style='color:#005000;'>WEBHARD</span>";
                   subject="<a style='color:black' href='startmain.jsp?content=webhard/webhard_getData.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"&mypage=2'>"+item.bsubject+"</a>";
                }else{
                   type="<span style='color:orange;'>COMMUNITY</span>";
                   subject="<a style='color:black' href='startmain.jsp?content=community/commu_select.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"&mypage=2'>"+item.bsubject+"</a>";
                       
                }
               
               
               
            str+="<tr>";
            str+="<td>"+(i+1)+"</td>";
            str+="<td>"+type+"</td>";
            str+="<td style='text-align:left'>"+subject+"</td>";
            str+="<td>"+item.bwriter+"</td>";
            str+="<td>"+item.bwriteday+"</td>";
            str+="<td><a href='mypage/adminboard_deleteaction.jsp?bnum="+item.bnum+"' style='color:black'>삭제</a></td>";
            str+="</tr>";
            })
            }
            $("#boardbody").html(str);
            
            
            paging(pageNum,startPage,endPage,totalPage,currentPage);
            
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
      pg+="<a href='#' style='color:black'><span class='pagebtn' pageNum='"+(endPage+1)+"'>NEXT</span></a>";
      
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}



</script>
<div style="width:100%;">
	<div style="width:70%;">
<h1  id="setting">SETTING BOARD</h1>
  <hr id="settinghr">
<table id="boardlist">
   <thead>
   <tr>
      <th style="width:5%;">번호</th>
      <th style="width:10%;">게시판</th>
      <th style="width:45%;">제목</th>
      <th style="width:15%;">작성자</th>
      <th style="width:15%;">작성일</th>
      <th style="width:10%;">삭제</th>
   </tr>
   </thead>
   <tbody id="boardbody"></tbody>
</table>
<div style="display:inline-block; ">
<select id="category" >
   <option value="bsubject">제목</option>
   <option value="bcontent">내용</option>
</select>
<input type="text" style="width:400px;" id="searchtxt" required="required">
<button type="button"  id="srchBtn">SEARCH</button>
</div>
<div id="paging"></div>
	</div>
</div>
</body>
</html>