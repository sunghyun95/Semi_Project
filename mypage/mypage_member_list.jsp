<%@page import="java.io.File"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
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
#membertable{
         width:100%;
         margin-bottom: 10%; 
   }
/*    #membertable th, #membertable td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  #membertable td{
     text-align:center;
  } */
  #mlisthr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    margin-bottom: 2%;
}
#mlist{
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
   
}
</style>
</head>
<%
   String root=request.getContextPath();
   String num=request.getParameter("num");
   MemberDao dao = new MemberDao();
   MemberDto dto = dao.getMember(num);
   String pageNum = request.getParameter("pageNum");
%>
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
   
      if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
         
         pageNum = $(this).attr("pageNum");
         //alert("searchtxt null"+pageNum);
         list(null,null,pageNum);                  
      
      }else{//검색어가 있을때
            var searchtxt = $("#searchtxt").val();
            var category = $("#category").val();
            pageNum = $(this).attr("pageNum");
            
            /*alert("sort null="+pageNum);
            alert(category+","+searchtxt+","+pageNum);*/
            list(category,searchtxt,pageNum);                  
            
      }      
      
});
    $(document).on("click","a.sendMessage",function(){
      var writernum = $(this).attr("writernum");
      window.open("message/sendMessage.jsp?writernum="+writernum,"","width=600px,height=365px,left=600px,top=100px");
   });
   
   
});

function delck(){
   return confirm("정말로 삭제하시겠습니까?");
}

function list(category,searchtxt,pageNum){
   $.ajax({
      type:"post",
      url:"mypage/mypage_member_DB.jsp",
      dataType:"json",
      data:{"category":category,"searchtxt":searchtxt,"pageNum":pageNum},
      success:function(data){
         var str="";
         if(data.length==0)
            {
            str+="<tr><th colspan='10'>사원이 존재하지 않습니다</th></tr>";
            }
         else{
            $.each(data,function(i,item){
               
               startPage = item.startPage;
                  endPage = item.endPage;
                  totalPage = item.totalPage;
                  currentPage = item.currentPage;
                  pageNum = item.pageNum;
               
               
                     str+="<div style=' display:inline-block; width:600px; margin-bottom:1%; font-size:12pt' >";
               str+="<table  style=' width:500px; background-color:#F6F6F6;'>";
               
               str+="<tr><td rowspan='8' style='width:180px;' align='center'><img src='saveimage/"+item.image+"' style='width:170px; height:192px;'></td>";            	   
              
               str+="<td style='width:80px;'>이름</td>";
               str+="<td><b>"+item.name+"</b></td></tr>";
               str+="<tr><td>사원번호</td>";
               if(item.id==" "){
                  str+="<td style='color:red;'>미발급</td></tr>";
               }else{
                  str+="<td>"+item.id+"</td></tr>";                     
               }
               str+="<tr><td>부서</td>";
               str+="<td>"+item.buseo+"</td></tr>";
               str+="<tr><td>핸드폰</td>";
               str+="<td>"+item.hp+"</td></tr>";
               str+="<tr><td>입사 일</td>";
               str+="<td>"+item.ipsaday+"</td></tr>";
               str+="<tr><td>게시글 수</td>";
               str+="<td>"+item.totalcount+"</td></tr>";
               str+="<tr><td colspan='2' style='text-align:right;'>";
               str+="<a href='#' style='color:black' class='sendMessage' writernum='"+item.num+"'>SMS</a>&nbsp;</td></tr>";
               str+="<tr><td colspan='2' style='text-align:right;'>";
               str+="<a style='color:black;' href='startmain.jsp?content=mypage/mypageupdateform.jsp?num="+item.num+"'>수정</a>";
               str+="&nbsp;|&nbsp;";
               str+="<a href='mypage/mypagedelete_action.jsp?num="+item.num+"' style='color:black;'>삭제</a>&nbsp;";
               str+="</table></div>";
               if((i+1)%2==0){
                  str+="<br>";
               }
            });
            
         }
         $("#memlist").html(str);
         
          paging(pageNum,startPage,endPage,totalPage,currentPage);
      },
      error:function(data){
         console.log("error:function")
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
      pg+="<a href='#' style='font-size:15pt; color:black'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
      
          
      }else{
         pg+="<a href='#'  style='color:black'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
         
      }
      
   }
   
   if(endPage < totalPage){
      pg+="<a href='#'  style='color:black'><span class='pagebtn' pageNum='"+(endPage+1)+"'>NEXT</span></a>";
      
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}


</script>
</script>
<body>
<div style="width:100%;">
	<div style="width:70%;">
<h1  id="mlist">MEMBER LIST</h1>
   <a href="startmain.jsp?content=mypage/insertmemberform.jsp" id="insert">ADD</a><br><br>
   <hr id="mlisthr">
<table id="membertable">
   <tbody id="selfbody">
   <tr >
   <td colspan="2" align="center" style=" padding-bottom:3%;">
      <select id="category" >
         <option value="id">사원번호</option>
         <option value="name">이름</option>
         <option value="buseo">부서</option>
      </select>
      <input type="text"  id="searchtxt" required="required" style="width:400px;">
         <button type="button"  id="srchBtn">SEARCH</button>&nbsp;&nbsp;&nbsp;&nbsp;
   </td>
   </tr>
   <tr><td colspan="2" id="memlist" align="center"></td></tr>
   </tbody>
</table>
<div id="paging"></div>
</div> 
	</div>
</body>
</html>