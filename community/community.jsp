
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
String num=request.getParameter("num");
String pageNum = request.getParameter("pageNum");

%>
<style>
.commulist{
   width: 100%;
}
.img-wrapper{
position: relative;
 box-shadow: 0 1px 10px rgba(0,0,0,0.5);
}
.darkness {
  position:absolute;
  top:0;
  left:0; 
  width:100%;
  height:100%;
  background-color:#000000;
  /* 추가된 부분 */
  opacity:0;
  transition:all .6s linear;

}
.btn-plus {
  position:absolute;
  top:40%;
  left:40%;
  background:orange;
  width:70px;
  height:70px;
  line-height:60px;
  border-radius:50%;
  text-align:center;
  /* 추가된 부분 */
  opacity:0;
  transform:scale(2);
  transition:all .3s linear;
 
}
.btn-plus span {
  font-size:2.3em;
  color:#ffffff;
  user-select:none;
}

/* 추가된 부분 */
.img-wrapper:hover .darkness{
  opacity:0.4;
}

/* 추가된 부분 */
.img-wrapper:hover .btn-plus {
  opacity:1;
  transform:scale(1);
}
#commuhr{
border: 0;
    height: 3px;
    background-image: -webkit-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    background-image: -moz-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    background-image: -ms-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    background-image: -o-linear-gradient(left, #f0f0f0, orange, #f0f0f0);
    margin-bottom: 2%;
}
#commu{
   font-weight: 700;
    height: 150px;
    text-align: left;
    font-size: 30pt;
    margin-bottom: 0;
    color: orange;
}
#insert{
   float: right;
   margin-right: 2%;
   font-size: 15pt;
   color: orange;
   
}
#paging{
   color: black;
}
</style>
<script type="text/javascript">
var startPage = "";
var endPage = "";
var totalPage = "";
var currentPage = "";
var pageNum = "<%=pageNum%>";
   $(function() {
       list(null,null,pageNum);

         $(document).on("click","a.sendMessage",function(){
            var writernum = $(this).attr("writernum");
            window.open("message/sendMessage.jsp?writernum="+writernum,"","width=600px,height=450px,left=600px,top=100px");
         });
       
      $("#srchBtn").click(function() {

         pageNum = 1;
         var searchtxt = $("#searchtxt").val();
         var category = $("#category").val();

         list(category, searchtxt, pageNum);
      });
      
      
      
         $(document).on("click","span.pagebtn",function(){
            pageNum = $(this).attr("pageNum");
          //   alert(pageNum);
          //   alert($("#searchtxt").val()); 
         
            if($("#searchtxt")==""||$("#searchtxt").val().length==0||$("#searchtxt").val()==null){ //검색어가 없을때
                
                
                   pageNum = $(this).attr("pageNum");
                   
                
                   list(null,null,pageNum);
                
            }else{
                   
                        var searchtxt = $("#searchtxt").val();
                        var category = $("#category").val();
                        pageNum = $(this).attr("pageNum");
                      
                        list(category,searchtxt,pageNum);                  
                        
            }
             	
       });
   });
function list(category, searchtxt, pageNum) {
         
         $.ajax({
               type : "post",
               url : "community/communityDb.jsp",
               dataType : "json",
               data : {
            	  "category" : category,
                  "searchtxt" : searchtxt,
                  "pageNum" : pageNum
               },
               success : function(data) {
                  var str = "";
                  
                  if(data.length==0){
                      str+="<b>게시글이 존재하지 않습니다</b>"
                   
                   }else{
               $.each(data, function(i, item) {
                              startPage = item.startPage;
                              endPage = item.endPage;
                              currentPage = item.currentPage;
                              totalPage = item.totalPage;
                              pageNum = item.pageNum;
                              str+="<div class='img-wrapper' style='display:inline-block; width:25%;' float='left'>";
                              //str += "<a href='startmain.jsp?content=community/commu_select.jsp?bnum="
                                    +item.bnum+"&pageNum="+item.currentPage+"' >";
                              str+="<img src='savecommu/"+item.filename+"' class='commuimg' style='width:100%; height:300px; background-color:#F6F6F6;'>";
                              //str+="</a>";
                              str+="<br>";                           
                              str+="<span style='margin-left:1%; line-height:25px'><img src='image/redheart.png' style='width:20px; height:20px'>"+item.likes;
                              str +="<img src='image/view.jpg' style='width:25px; height:25px'>"+item.breadcount+"</span>";
                              str +="<span style='float:right; margin-right:1%; line-height:25px'>"+item.name+"</span>";
                              str+="<div class='darkness'></div>";
                              str+="<div class='btn-plus'><a href='startmain.jsp?content=community/commu_select.jsp?bnum="+item.bnum+"&pageNum="+item.currentPage+"'><span draggable='false'>+</span></a></div>";
                              str+="</div>&nbsp;&nbsp;";
                              if ((i + 1) % 3 == 0)
                                 str += "<br><br>";
                           });
                   }
                 
                  $(".commulist").html(str);

                  paging(pageNum, startPage, endPage, totalPage, currentPage);
               }
            })
   }


function paging(pageNum,startPage,endPage,totalPage,currentPage){
   var pg = "";
   pg += "<ul style='text-align:center;'>";

   if(startPage > 1){
      
      pg+="<a href='#'><span class='pagebtn' pageNum='"+(startPage-1)+"'>BACK</span></a>";
      
   }
   
   for(var i=startPage; i<=endPage; i++){
      
      if(i==currentPage){
      pg+="<a href='#' style='font-size:15pt;'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
      
          
      }else{
         pg+="<a href='#'><span class='pagebtn' pageNum='"+i+"'>"+i+"</span></a>";
         
      }
      
   }
   
   if(endPage < totalPage){
      pg+="<a href='#'><span class='pagebtn' pageNum='"+(endPage+1)+"'>NEXT</span></a>";
      
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}


</script>
<body>
<div style="width:100%;">
	<div style="width:70%;">
<h1  id="commu">COMMUNITY</h1>
   <a href="startmain.jsp?content=community/commu_insertform.jsp" id="insert">INSERT</a><br><br>
   <hr id="commuhr">
   <div class="commulist" style="float:left;padding-left:16%; ;padding-bottom: 2%; margin-left:-4%;" align="left">
   </div>
   <select id="category" >
      <option value="bsubject">제목</option>
      <option value="bcontent">내용</option>
   </select>
   <input type="text"  id="searchtxt" style="width: 400px;">
   <button type="button"  id="srchBtn">SEARCH</button>
   <br>
   <div id="paging"></div>	
	</div>
</div>
</body>
</html>