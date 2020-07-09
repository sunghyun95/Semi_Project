<%@page import="intranet.dao.LikesDao"%>
<%@page import="intranet.dto.ReplyDto"%>
<%@page import="intranet.dao.ReplyDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="java.util.Vector"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="intranet.dto.BoardDto"%>
<%@page import="intranet.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%
   String root = request.getContextPath();
   request.setCharacterEncoding("UTF-8");
   String num = (String)session.getAttribute("num");   

   String mypage = request.getParameter("mypage");
   String bnum = request.getParameter("bnum");
   String pageNum = request.getParameter("pageNum");
   BoardDao dao = new BoardDao();
   dao.updateWebHardReadcount(bnum);
   BoardDto dto = dao.getWebHardData(bnum);
   
   
   
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  hh:mm");
   MemberDao mdao = new MemberDao();
   MemberDto mdto = mdao.getMember(dto.getNum());
   
   String path = getServletContext().getRealPath("/webhard/"+bnum);
   
   
   FileDao fdao = new FileDao();
   List<FileDto> flist = fdao.getCommuGetFilelist(bnum);   

   LikesDao ldao=new LikesDao();
   int likes=ldao.likesList(dto.getBnum());
   
%>
<style type="text/css">
span#scrap:hover{
   cursor:pointer;
}

#likes:hover{
	cursor:pointer;
}
#replyBtn{ 

  background-color: #e7e7e7; /* Green */
  border: none;
  color: black;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

#cancelbtn {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
}

#updatebtn{
	background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
}
#bcontent {
  width: 500px;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
	height:450px;
	border:1px solid gray;
}
#delbtn{
	background-color: #f44336	; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
}
#mailbtn{
  background-color: #555555; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
}

.updatecontent{
	width:430px;
}


#webhardselecttable{
	margin-top:2%;
}

.replycontent{
	width:500px;
}

#rcontent{
	width:430px;
}

#replyBtn{
	width:70px;
	height:36px;
	font-size:5pt;
}

#listbtn{
  background-color: #008CBA; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
  
}

.updateactionBtn{
	width:70px;
	height:36px;
	font-size:5pt;
  background-color: #008CBA; /* Green */
  border: none;
  color: white;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  float:right;
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

</style>
<script type="text/javascript">
var str = "";
var content = "";
var startPage = "";
var endPage = "";
var totalPage = "";
var currentPage = "";
var pageNum = "";
   $(function(){
      likesheart(<%=bnum%>);
      scrapstar(<%=bnum%>);
      replyList(<%=bnum%>);
      
       $("span#likes").click(function(){
            var bnum = <%=bnum%>;
            var num = <%=num%>;
            var heart = $(this).children().attr("src");
            //alert(하트);
            if(heart.length == 20){
               
               $.ajax({
                  type:"get",
                  url:"likes/insertLikes.jsp",
                  dataType:"html",
                  data:{"bnum":bnum,"num":num},
                  success:function(){
                     $("#empty").detach();
                     //18
                     str = "<img src='image/redheart.png' style='width:20px; height:20px;' id='red'>";
                     showlikes(str);
                     swal("공감 완료!", "해당 게시글에 공감을 완료하였습니다", "success");
                  },
                  error:function(data){
                     console.log("error:function");
                     console.log(data);
                     
                  }
               });
               
            }else{
               $.ajax({
                  type:"get",
                  url:"likes/deleteLikes.jsp",
                  dataType:"html",
                  data:{"bnum":bnum,"num":num},
                  success:function(){
                     $("#red").detach();
                     //20
                     str = "<img src='image/emptyheart.png' style='width:20px; height:20px; color:red;' id='empty'>";
                     showlikes(str);
                     swal("공감 취소!", "해당 게시글에 공감을 취소하였습니다", "error");
                  },
                  error:function(data){
                     console.log("error:function");
                     console.log(data);
                  }
               });
            }
         })
         
         function showlikes(str){
            $("span#likes").append(str);
         }
       
         function likesheart(){
            var bnum=<%=bnum%>;
            var num = <%=num%>;
            $.ajax({
               type:"get",
               url:"likes/getLikesType.jsp",
               dataType:"json",
               data:{"bnum":bnum,"num":num},
               success:function(data){
                  $.each(data, function(i,item){
                     if(item.likes==0){
                        str = "<img src='image/emptyheart.png' style='width:20px; height:20px; color:red;' id='empty'>";
                        showlikes(str);
                        
                     }else{
                        str = "<img src='image/redheart.png' style='width:20px; height:20px;' id='red'>";
                        showlikes(str);
                     }
                     
                  });
                  
               },
               error:function(data){
                  console.log("error:function");
                  console.log(data);
               }
            });
         }
      
      
      
      $("span#scrap").click(function(){
         var bnum = <%=bnum%>;
         var num = <%=num%>;
         var star = $(this).children().eq(1).attr("src");
         
         if(star.length == 19){
            
            $.ajax({
               type:"get",
               url:"scrap/insertScrap.jsp",
               dataType:"html",
               data:{"bnum":bnum,"num":num},
               success:function(){
                  $("#clock").detach();
                  str = "<img src='image/yellowstar.png' style='width:20px; height:20px;' id='yellow'>";
                  showstar(str);
                  swal("스크랩 완료!", "해당 게시글에 스크랩을 완료하였습니다", "success");
               },
               error:function(data){
                  console.log("error:function");
                  console.log(data);
                  
               }
            });
            
         }else{
            $.ajax({
               type:"get",
               url:"scrap/deleteScrap.jsp",
               dataType:"html",
               data:{"bnum":bnum,"num":num},
               success:function(){
                  $("#yellow").detach();
                  str = "<img src='image/clockstar.png' style='width:20px; height:20px;' id='clock'>";
                  showstar(str);
                  swal("스크랩 취소!", "해당 게시글에 스크랩을 취소하였습니다", "error");
               },
               error:function(data){
                  console.log("error:function");
                  console.log(data);
               }
            });
         }
      });
      
      $("#delbtn").click(function(){
         var bnum = <%=dto.getBnum()%>;
         var pageNum=<%=pageNum%>;
         swal({
             title: "삭제하시겠습니까?",
             text: "한번 삭제된 자료는 복구되지 않습니다",
             icon: "error",
             buttons: true,
             dangerMode: true,
           })
           .then(function(willDelete){
             if (willDelete) {
                $.ajax({
                       type:"post",
                       url:"webhard/webhard_deleteaction.jsp",
                       dataType:"html",
                       data:{"bnum":bnum,"pageNum":pageNum},
                       success:function(){
                          /* alert("게시글이 삭제되었습니다."); */
                          location.href= "webhard/webhard_del_check.jsp?pageNum="+pageNum;
                       }
                    });
             } else {
               return;
             }
           });
         
         
      });
      
      $("#replyBtn").click(function(){
         var rcontent = $("#rcontent").val();
         var bnum = $(this).attr("bnum");
         var pageNum = $(this).attr("pageNum");
         $.ajax({
            type:"post",
            url:"webhard/webhard_insertReply.jsp",
            dataType:"html",
            data:{"rcontent":rcontent,"bnum":bnum},
            success:function(){
               replyList(<%=bnum%>);
               $("#rcontent").val("");
            },
            error:function(data){
               console.log("error:function");
               console.log(data);
            }
         });
      });
      var data = "";
      $(document).on("click",".updatebtn",function(){
         var content = $(this).parent().parent().next().children().children().text(); //pre
         data = $(this).parent().parent().next().children().children().detach(); // pre
         
         $(this).parent().parent().next().children().append("<textarea class='updatecontent'></textarea>&nbsp; <button type='button' class='updateactionBtn'>UPDATE</button>");
         $(this).parent().parent().next().children().children().val(content);

      });
      
      $(document).on("click",".updateactionBtn",function(){
         var rcontent = $(this).prev().val();
         var rnum = $(this).parent().parent().prev().prev().children().children().eq(0).val();
      
         $.ajax({
            type:"post",
            url:"webhard/webhard_updateReplyAction.jsp",
            dataType:"html",
            data:{"rcontent":rcontent,"rnum":rnum},
            success:function(){
               replyList(<%=bnum%>);
            }
         });      
      });
      
      $(document).on("click",".delbtn",function(){
         var rnum = $(this).parent().parent().prev().children().children().eq(0).val();

         swal({
             title: "댓글 삭제",
             text: "댓글 삭제를 진행합니다",
             icon: "info",
             buttons: true,
             dangerMode: true,
           })
           .then(function(willDelete){
             if (willDelete) {
                $.ajax({
                       type:"post",
                       url:"webhard/webhard_deleteReplyAction.jsp",
                       dataType:"html",
                       data:{"rnum":rnum},
                       success:function(){
                          replyList(<%=bnum%>);
                       }
                    });   
             } else {
               return;
             }
           });
         
      });
      
      $("#mailbtn").click(function(){
         var bnum = <%=bnum%>;
         
         swal({
             title: "전송 완료",
             text: "귀하의 메일로 전송이 완료되었습니다.",
             icon: "success",
             buttons: true,
             dangerMode: true,
           })
           .then(function(willDelete){
             if (willDelete) {
                $.ajax({
                       type:"post",
                       url:"email/sendMail.jsp",
                       dataType:"json",
                       data:{"bnum":bnum},
                       success:function(){
                       }
                    });
             } else {
               return;
             }
           });
         
      });
      
   });

function showstar(str){
   
   $("span#scrap").append(str);
   
}   
   
function scrapstar(){
   var bnum = <%=bnum%>;
   var num = <%=num%>;
   $.ajax({
      type:"get",
      url:"scrap/getScrapType.jsp",
      dataType:"json",
      data:{"bnum":bnum,"num":num},
      success:function(data){
         $.each(data, function(i,item){
            if(item.scrap==0){
               str = "<img src='image/clockstar.png' style='width:20px; height:20px;' id='clock'>";
               showstar(str);
               
            }else{
               str = "<img src='image/yellowstar.png' style='width:20px; height:20px;' id='yellow'>";
               showstar(str);
            }
            
         });
         
      },
      error:function(data){
         console.log("error:function");
         console.log(data);
      }
   });
}   
   
function replyList(bnum)
{
   $.ajax({
      type:"post",
      url : "webhard/webhard_replyList.jsp",
      dataType:"json",
      data:{"bnum":bnum},
      success:function(data){
         var str = "";
         
         str+="<table style='border-bottom:1px solid #blue;'>";
         
         $.each(data,function(i,item){
            str+="<tr>";
            str+="<td style='border-top:1px solid green;'><input type='hidden' value='"+item.rnum+"' name='rnum'>"+item.name+"&nbsp;"+item.rwriteday+"</td>";      
            str+="</tr>";
            str+="<tr>";
            str+="<td style='border-top:1px solid pink;'><a href='#' style='float:right;' class='delbtn'>삭제</a><a href='#' style='float:right;' class='updatebtn'>수정</a></td>";
            str+="</tr>";
            str+="<tr>";
            str+="<td><pre class='replycontent' style='border-bottom:1px solid pink;'>"+item.rcontent+"</pre></td>";
            str+="</tr>";         
         });
         
         str+="</table>";
      $("#replytable_container").html(str);
      }
   });
   
   
}

function paging(pageNum,currentPage,startPage,endPage,totalPage){
   var pg = "";
   pg += "<ul class='pagination'>";
   
   if(startPage > 1){
      pg+="<li>";
      pg+="<a class='previous'>"+BACK+"</a>";
      pg+="</li>";
   }
   
   for(var i=startPage; i<=endPage; i++){
      
      if(i==currentPage){
      pg+="<li class='active'>";
      pg+="<a href='#'>"+i+"</a>";
      pg+="</li>";
          
      }else{
         pg+="<li>";
         pg+="<a href='#'>"+i+"</a>";
         pg+="</li>";
      }
      
   }
   
   if(endPage < totalPage){
      pg+="<li>";
      pg+="<a href='#'>"+NEXT+"</a>";
      pg+="</li>";
   }
   pg+="</ul>";
   
   $("#paging").html(pg);
}



</script>
</head>
<body>
<div style="width:100%;">
	<div style="width:70%;">
<h1 id="webh">WEBHARD</h1>
	<hr id="webhr">

<table class="table table-bordered" id="webhardselecttable"> 
   <tr>
      <td colspan="3">
         <span style="float:left; font-size:20pt;"><%=dto.getBsubject() %></span>
         <span style="float:right; color:blue; margin-bottom:2%;"><%=sdf.format(dto.getBwriteday()) %></span>
      </td>
   </tr>
   <tr>
      <td colspan="3">
         <span style="color:orange;"><%=mdto.getBuseo() %></span>&nbsp;<span><%=mdto.getName() %>(<%=mdto.getId() %>)</span>
         
         <span style="float:right;"><b><%=dto.getBreadcount() %></b></span>
      </td>
   </tr>
   <tr>
      <td colspan="3">
         <pre id="bcontent"><%=dto.getBcontent()%></pre>
      </td>
   </tr>
   <tr>
      <td>
         <span id="scrap" style="float:left;">
         <span style="float:left;">SCRAP</span>
         </span>
       <span id="contentnotice" style="float:left;">LIKE</span>
         <span id="likes" style="float:left;"></span>
      </td>
   </tr>
   <%
      for(int i=0; i<flist.size(); i++)
      {%>
         <tr>
            <td colspan="3">
                <a href="webhard/filedownaction.jsp?bnum=<%=dto.getBnum() %>&getfilename=<%=flist.get(i).getFilename()%>"><%=flist.get(i).getFilename()%></a>
            </td>
         </tr>
      <%}
   %>
</table>
<div>
<div id="replytable_container">

</div>
<table>
   <tr>
   <td>
      <textarea class="form-control" id="rcontent"></textarea>
   </td>
   <td>
      <button type="button" bnum="<%=dto.getBnum()%>" pageNum="<%=pageNum %>" id="replyBtn">WRITE</button>
   </td>
   </tr>
   <tr>
   	<td colspan="3">
   	<button type="button" onclick="location.href='<%=root%>/startmain.jsp?content=webhard/webhard_updateform.jsp?bnum=<%=dto.getBnum()%>&pageNum=<%=pageNum%>'" id ="updatebtn">UPDATE</button>
<button type="button"  id="delbtn">DELETE</button>
<button type="button"  id="mailbtn">SEND MAIL</button>


<%if(mypage==null){%>
<button type="button" onclick="location.href='<%=root%>/startmain.jsp?content=webhard/webhard_publiclist.jsp?pageNum=<%=pageNum%>'" id="listbtn">LIST</button>

<%}else{

   if(mypage.equals("1")){%>
<button type="button" onclick="location.href='<%=root%>/startmain.jsp?content=mypage/normalboard.jsp?pageNum=<%=pageNum%>'" id="listbtn">LIST</button>      
   <%}else{%>
      
<button type="button" onclick="location.href='<%=root%>/startmain.jsp?content=mypage/adminboard_form.jsp?pageNum=<%=pageNum%>'" id="listbtn">LIST</button>
   <%}
%>

<%}%>
   	
   	</td>
   </tr>
</table>

</div>
      
	
	</div>
</div>
</body>
</html>