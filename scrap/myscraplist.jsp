<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<style type="text/css">
   #myscrap{
         width:100%;
         margin-bottom: 10%; 
         width:100%;
   }
   #myscrap th, #myscrap td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
    #scraplisthr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    margin-bottom: 2%;
}
#scraplist{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #8C8C8C;
}
.delscrap{
   color:gray;
   float:right;
   margin-right: 2%;
   font-size: 15pt;
}
</style>
<%
   String num=(String)session.getAttribute("num");
   String bnum=request.getParameter("bnum");
   String pageNum = request.getParameter("pageNum");
   String root=request.getContextPath();
%>
<body>
<div style="width:100%;">
	<div style="width:70%;">
	
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
            var searchtxt = $("#searchtxt").val();
            var category = $("#category").val();
            pageNum = $(this).attr("pageNum");
            
            /*alert("sort null="+pageNum);
            alert(category+","+searchtxt+","+pageNum);*/
            list(category,searchtxt,pageNum);                  
            
      }      
      
});
   $("#delbtn").click(function(){
      var data=[];
     $(".ckbox:checked").each(function(){
        data.push($(this).val());
     })
     
     swal("삭제 완료"," ","success")
.then(function(value){
   location.href="scrap/myscrapdel_action.jsp?bnum="+data;
});
      
   });
   
   
});
function list(category,searchtxt,pageNum){
   var type="";
   var subject = "";
   $.ajax({
      type:"post",
      url:"scrap/myscraplist_action.jsp",
      dataType:"json",
      data:{"category":category,"searchtxt":searchtxt,"pageNum":pageNum},
      success:function(data){
         //alert("성공?");
         var str="";
         if(data.length==0)
            {
             str+="<tr><th colspan='6'>게시글이 존재하지 않습니다</th></tr>"
            }
         else{
            $.each(data,function(i,item){
               
               startPage = item.startPage;
                  endPage = item.endPage;
                  totalPage = item.totalPage;
                  currentPage = item.currentPage;
                  pageNum = item.pageNum;
               
                  
                  
                  if(item.boardtype==1){
                      type="<span style='color:blue;'>NOTICE</span>";
                      subject="<a style='color:black;' href='startmain.jsp?content=notice/notice_content.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"&mypage=1'>"+item.bsubject+"</a>";
                   }else if(item.boardtype==5){
                      type="<span style='color:skyblue;'>WEBHARD</span>";
                      subject="<a style='color:black;' href='startmain.jsp?content=webhard/webhard_getData.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"&mypage=1'>"+item.bsubject+"</a>";
                   }else{
                      type="<span style='color:orange;'>COMMUNITY</span>";
                      subject="<a style='color:black;' href='startmain.jsp?content=community/commu_select.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"&mypage=1'>"+item.bsubject+"</a>";
                        
                   }
                  
                  
               //수정해야 할 부분 0418_오후 4시반ㄴ
                  str+="<tr align='center'>";
                  str+="<td><input type='checkbox' class='ckbox' name='ckbox' value='"+item.bnum+"'></td>";
                  str+="<td>"+type+"</td>";
                  str+="<td style='text-align:left'><a>"+subject+"</a></td>";
                  str+="<td>"+item.name+"</td>";
                  str+="<td>"+item.writeday+"</td>";
                  str+="</tr>";
            });
         }
         
         $("#scrapbody").html(str);
         
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
      pg+="<a href='#'  style='color:black'><span class='pagebtn' pageNum='"+(endPage+1)+"'>NEXT</span></a>";
      
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}

</script>
<!-- <button type="button" style="float:right;" id="srchBtn">SEARCH</button>
<input type="text" style="float:right;" id="searchtxt" required="required">
<select id="category" style="float:right;">
   <option value="bsubject">제목</option>
   <option value="bcontent">내용</option>
</select> -->
<h1  id="scraplist">MY SCRAP</h1>
<a href="#"  class="delscrap" id="delbtn">DELETE</a>
  <br><br>
   <hr id="scraplisthr">

<table id="myscrap">
   <thead>
   <tr>
      <th style="width:5%; text-align:center;"></th>
     <th style="width:20%; text-align:center;">게시판</th>
     <th style="width:50%; text-align:center;">제목</th>
     <th style="width:15%; text-align:center;">작성자</th>
     <th style="width:10%; text-align:center;">스크랩날짜</th>
   </tr>
   </thead>
   <tbody id="scrapbody"></tbody>
</table>
<div id="paging" style="align:center;"></div>
	</div>
</div>
</body>
</html>