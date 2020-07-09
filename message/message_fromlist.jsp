<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<%
   request.setCharacterEncoding("UTF-8");
   String pageNum = request.getParameter("pageNum");
   String root = request.getContextPath();
%>
<style type="text/css">
   #fromtablelist{
      width:100%;
   }

   #fromtablelist th, #fromtablelist td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  #from,#to{
     width:150px;
     height:50px;
     line-height:50px;
     display: inline-block;
     float:left;
     margin-top:1%;
     margin-left:1%;
  }
  #from{
     background-color:PINK;
  }
  #to{
     background-color:GRAY;   
  }
  
  #fromatag,#toatag{
     font-weight:bold;
   text-decoration:none;
   color:white;     
  }
      #msglisthr{
   border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, #8C8C8C, #f0f0f0);
    margin-bottom: 2%;
    margin-top: 3%;
}
#msglist{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: #8C8C8C;
}
.writebtn{
   color:gray;
   float:right;
   margin-right: 2%;
   padding-top: 3%;
   font-size: 15pt;
}
  
</style>
<script type="text/javascript">
var startPage = "";
var endPage = "";
var totalPage = "";
var currentPage = "";
var mwriter = "mwriter";
var pageNum = "<%=pageNum%>";
$(function(){
   list(mwriter,null,null,pageNum);
     
     $(document).on("click","#sendMessage",function(){
         window.open("message/message_writeform.jsp","","width=600px,height=450px,left=600px,top=100px");

     });
   
     $("#srchBtn").click(function(){
        
         pageNum = 1;
         var searchtxt = $("#searchtxt").val();
         var category = $("#category").val();
         
         alert("category="+category);
         alert("searchtxt="+searchtxt);
         
         list(mwriter,category,searchtxt,pageNum);
      });
      
      $(document).on("click","span.pagebtn",function(){
         pageNum = $(this).attr("pageNum");
       //   alert(pageNum);
       //   alert($("#searchtxt").val()); 
      
         if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
            
            pageNum = $(this).attr("pageNum");
            //alert("searchtxt null"+pageNum);
            list(mwriter,null,null,pageNum);                  
         
         }else{//검색어가 있을때
               var searchtxt = $("#searchtxt").val();
               var category = $("#category").val();
               pageNum = $(this).attr("pageNum");
               /* alert("sort null="+pageNum);
               alert(category+","+searchtxt+","+pageNum); */
               list(mwriter,category,searchtxt,pageNum);                  
               
         }      
         
   });
   
});

function list(mwriter,category,searchtxt,pageNum){
         var str = "";
         var write="";
   $.ajax({
      type:"post",
      url:"message/message_fromlist_action.jsp",
      dataType:"json",
      data:{"mwriter":mwriter,"category":category,"searchtxt":searchtxt,"pageNum":pageNum},
      success:function(data){
            str+="<table id='fromtablelist'>";
            str+="<tr>";
            str+="<th style='width:10%;'>받은사람</th>";
            str+="<th style='width:40%;'>내용</th>";
            str+="<th style='width:10%;'>보낸날짜</th>";
            
            
            str+= "</tr>";

            $.each(data, function(i,item){
               
               startPage = item.startPage;
                  endPage = item.endPage;
                  totalPage = item.totalPage;
                  currentPage = item.currentPage;
                  pageNum = item.pageNum;
                  
                  
               if(item.totalcount==0){
                  str+="<tr><td><b>보낸 쪽지가 없습니다</b></td></tr>";
               }else{
                  
                  if(item.mwriterdel==0){
                     
             str+="<tr>";            
            str+="<td style='text-align:center;'>"+item.reader+"("+item.readerid+")</td>";
            str+="<td><a href='<%=root%>/startmain.jsp?content=message/message_select.jsp?mnum="+item.mnum+"&pageNum="+item.currentPage+"&message=1' style='color:black'>"+item.mcontent+"</a></td>";
            str+="<td style='text-align:center;'>"+item.mwriteday+"</td>";
            
             str+="</tr>";                  
                  }
                     
               }
               
         });
            str+="</table>";
            write+="<a href='#'class='writebtn' id='sendMessage' >WRITE</a>";
               
         $("#frommessagelist").html(str);
         $("#write").html(write);
         
         
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
      
      pg+="<a href='#' style='color:black;'><span class='pagebtn' pageNum='"+(startPage-1)+"'>BACK</span></a>";
      
   }
   
   for(var i=startPage; i<=endPage; i++){
      
      if(i==currentPage){
      pg+="<a href='#' style='font-size:15pt; color:black'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
      
          
      }else{
         pg+="<a href='#' style='color:black;'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
         
      }
      
   }
   
   if(endPage < totalPage){
      pg+="<a href='#' style='color:black;'><span class='pagebtn' pageNum='"+(endPage+1)+"'>NEXT</span></a>";
      
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}

</script>
</head>
<body>
<div style=width:100%;>
<div style="width:70%;">
<h1  id="msglist">MY MESSAGE<span style="color:pink">_</span><span style="font-size: 13pt; color:pink">FROM</span></h1>
<div id="from"><a id="fromatag" href="startmain.jsp?content=message/message_fromlist.jsp">FROM MESSAGE</a></div>
<div id="to" ><a id="toatag" href="startmain.jsp?content=message/message_tolist.jsp">TO MESSAGE</a></div>
<div id="write"></div>
<br><br>
<hr id="msglisthr">
<div id="frommessagelist"></div>
<div style="display:inline-block; padding-top:3% ">
<select id="category" >
   <option value="mcontent">내용</option>
</select>
<input type="text"  id="searchtxt" required="required" style="width:400px">
<button type="button"  id="srchBtn">SEARCH</button>
</div>
<div id="paging"></div>
</div>
</div>
</body>
</html>