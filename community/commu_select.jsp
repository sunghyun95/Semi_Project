<%@page import="intranet.dao.LikesDao"%>
<%@page import="intranet.dto.MemberDto"%>
<%@page import="intranet.dao.MemberDao"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dto.CommuDto"%>
<%@page import="intranet.dao.CommuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
</head>
<%
   request.setCharacterEncoding("utf-8");
   String root=request.getContextPath();
   String bnum=request.getParameter("bnum");
   String num=(String)session.getAttribute("num");
   String pageNum=request.getParameter("pageNum");
   String mypage = request.getParameter("mypage");
   System.out.println("mypage="+mypage);
   CommuDao dao=new CommuDao();
   
   dao.updateReadcount(bnum);
   
   CommuDto dto=dao.getCommu(bnum);
   
   FileDao fdao=new FileDao();
   FileDto fdto=fdao.getBnumFile(bnum);
   
   MemberDao mdao=new MemberDao();
   MemberDto mdto=mdao.getMember(num);
   
   MemberDao mdao2=new MemberDao();
   MemberDto mdto2=mdao2.getMember(dto.getNum());
   
   LikesDao ldao=new LikesDao();
   int likes=ldao.likesList(dto.getBnum());
%>
<style type="text/css">
span#scrap:hover{
   cursor:pointer;
}
#paging{
   color: black;
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
.img-wrapper{
   border:1px solid gray; 
   display:inline-block;
   width:45%;
   height: auto;
   box-shadow: 0 1px 10px rgba(0,0,0,0.5);
   margin-top: 2%;
}
#commuimage{
   width: 100%;
   height: 450px;
}
.commudiv{
   display: inline-block; 
   width:100%;
}
.commuspan{
   margin-left:1%; 
   line-height:30px; 
   float:left;
}
</style>
<script type="text/javascript">
$(function(){
   likesheart(<%=bnum%>);
   scrapstar(<%=bnum%>);
   replyList(<%=bnum%>);
   
   $("#delbtn").click(function(){
      var a = true;
          /* a = confirm("정말로 삭제하시겠습니까?"); */
         var pageNum = $(this).attr("pageNum");
         var bnum = <%=bnum%>;
      if(a){
         $.ajax({
            type:"post",
            url:"community/commu_deleteaction.jsp",
            dataType:"html",
            data:{"bnum":bnum},
            success:function(){
               location.href="community/commu_deleteaction.jsp?bnum=<%=bnum%>&pageNum=<%=pageNum%>";
            }
         });
      }
   });
   
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
               str = "<img src='image/redheart.png' style='width:30px; height:30px;' id='red'>";
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
               str = "<img src='image/emptyheart.png' style='width:30px; height:30px; color:red;' id='empty'>";
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
                  str = "<img src='image/emptyheart.png' style='width:30px; height:30px; color:red;' id='empty'>";
                  showlikes(str);
                  
               }else{
                  str = "<img src='image/redheart.png' style='width:30px; height:30px;' id='red'>";
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
               str = "<img src='image/yellowstar.png' style='width:35px; height:35px;' id='yellow'>";
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
               str = "<img src='image/clockstar.png' style='width:35px; height:35px;' id='clock'>";
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
      var content = $(this).parent().parent().prev().children().children().text(); //pre
      
      data = $(this).parent().parent().prev().children().children().detach(); // pre
      
      $(this).parent().parent().prev().children().append("<textarea class='updatecontent'></textarea>&nbsp; <button type='button' class='updateactionBtn'>UPDATE</button>");
      $(this).parent().parent().prev().children().children().val(content);

   });
   
   $(document).on("click",".updateactionBtn",function(){
      var rcontent = $(this).prev().val();
      var rnum = $(this).parent().parent().prev().children().children().eq(0).val();
   	  alert("rnum:"+rnum);
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
      var rnum = $(this).parent().parent().prev().prev().children().children().eq(0).val();
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
         }else {
             return;
         }
       });
      
      
   });
   
});

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
               str = "<img src='image/clockstar.png' style='width:35px; height:35px;' id='clock'>";
               showstar(str);
               
            }else{
               str = "<img src='image/yellowstar.png' style='width:35px; height:35px;' id='yellow'>";
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

function showstar(str){
   
   $("span#scrap").append(str);
   
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
         
         str+="<table style='background-color:#F6F6F6; width:95%'>";
         
         $.each(data,function(i,item){
            str+="<tr>";
            str+="<td style='width:50%'><input type='hidden' value='"+item.rnum+"' name='rnum'><b>"+item.name+"</b></td>";
            str+="<td align='right'>"+item.rwriteday.substring(0,16)+"</td>";      
            str+="</tr>";
            str+="<tr>";
            str+="<td colspan='2'><pre class='replycontent'>"+item.rcontent+"</pre></td>";
            str+="</tr>";         
            str+="<tr>";
            str+="<td colspan='2' align='right' style='border-bottom:2px solid white'>";
            str+="<a href='#'  class='updatebtn' style='color:black'>수정</a>&nbsp;|&nbsp;";
            str+="<a href='#'  class='delbtn' style='color:black'>삭제</a></td>";
            str+="</tr>";
         });
         
         str+="</table>";
      $("#replytable_container").html(str);
      }
   });
   
   
}

</script>
<body>
<div style="width:100%;">
   <div style="width:70%;">
<h1  id="commu">COMMUNITY_<span style="font-size: 13pt">VIEW</span></h1>
     <hr id="commuhr">
<div class="img-wrapper" >

   <img src="savecommu/<%=fdto.getFilename() %>" id="commuimage"><br>
   <div  class="commudiv">
      <span class="commuspan">
         <span id="likes" style="cursor: pointer" ></span><span id="scrap"><span></span></span> 
         <img src='image/view.jpg' style='width:30px; height:30px'><%=dto.getBreadcount() %>
      </span>
      <span style='float:right; margin-right:1%; line-height:30px; font-size: 14pt;'><%=mdto2.getName() %></span>
   </div>
   <div class="commudiv">
      <span class="commuspan" ><b>분류</b>&nbsp;&nbsp;<%=dto.getBcommu() %></span>
   </div>
   <div class="commudiv">
      <span class="commuspan" ><b>제목</b>&nbsp;&nbsp;<%=dto.getBsubject()%></span>
   </div>
   <div class="commudiv" style=" width:100%">
      <span style='margin-left:1%; float:left; width:100%'><b style="float:left">내용</b>&nbsp;&nbsp;
         <pre style=" display: inline-block; text-align:left; float: left;width:90%; padding-left: 3%" name="bcontent"><%=dto.getBcontent() %></pre>
      </span>
   </div>
   <div class="commudiv">
         <span class="commuspan"><b>댓글</b></span>
   </div>
   <div >
      <div id="replytable_container"></div>
      <table style="width:95%">
         <tr>
            <td style="width:90%;">
            <textarea  id="rcontent" style="width:100%"></textarea>
            </td>
            <td style="width:10%; text-align: center">
            <a href="#" bnum="<%=dto.getBnum()%>" pageNum="<%=pageNum %>" id="replyBtn" style="color:black;">WRITE</a>
            </td>
            
         </tr>
      </table>
   </div>
   
</div>


   <table style="margin-top: 2%">
   <%
      if(dto.getNum().equals(num) || mdto.getName().equals("관리자"))
      {%>
         <tr>
            <td colspan="2" style="font-size: 13pt;">
               <a  style="color:black" href="startmain.jsp?content=community/commu_updateform.jsp?bnum=<%=bnum%>&pageNum=<%=pageNum%>">UPDATE</a>&nbsp;&nbsp;
               <a href="#" id="delbtn" pageNum="<%=pageNum%>" style="color:black">DELETE</a>
               &nbsp;&nbsp;
               <%
               if(mypage==null){%>
               <a href="startmain.jsp?content=community/community.jsp?pageNum=<%=pageNum %>" style="color:black">LIST</a>               
               <%}else{%>
               
                  <%if(mypage.equals("1")) {%>
                <a href="startmain.jsp?content=mypage/normalboard.jsp?pageNum=<%=pageNum %>" style="color:black">LIST</a>   
                  
                  <%}else{%>
                   <a href="startmain.jsp?content=mypage/adminboard_form.jsp?pageNum=<%=pageNum %>" style="color:black">LIST</a>   
                  
                  <%}%>
               <%}%>
            </td>
         </tr>
      <%}else{%>
         <tr>
            <td colspan="2">
             <%if(mypage==null){%>
               <a href="startmain.jsp?content=community/community.jsp?pageNum=<%=pageNum%>" style="color:black">LIST</a>             
             <%}else{%>
                 <a href="startmain.jsp?content=mypage/normalboard.jsp?pageNum=<%=pageNum %>" style="color:black">LIST</a>                   
                <%}%>
             </td>
         </tr>
       <%} %>
</table>
</div>
</div>
</body>
</html>