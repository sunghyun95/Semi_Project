<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Vector"%>
<%@page import="intranet.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="intranet.dao.FileDao"%>
<%@page import="intranet.dao.BoardDao"%>
<%@page import="intranet.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String root=request.getContextPath();
   
   Cookie[] cookies = request.getCookies();
   String realPath = "";
   
   String folder = (String)session.getAttribute("bnum");
   realPath=getServletContext().getRealPath("/webhard/"+folder);

   session.removeAttribute("bnum");
   
   System.out.println("updateaction realpath"+realPath);
   
   MultipartRequest multi = null;
   
   int fileSize = 1024*1024*10;
   FileDao fdao = new FileDao();
   BoardDao bdao = new BoardDao();
   BoardDto bdto = new BoardDto();
   try{
      multi = new MultipartRequest(request, realPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
      String bsubject = multi.getParameter("bsubject");
      String bcontent = multi.getParameter("bcontent");
      String bnum = multi.getParameter("bnum");
      String num = multi.getParameter("num");
      String delfile = multi.getParameter("delfile");
      String pageNum = multi.getParameter("pageNum");
      String bopen = multi.getParameter("bopen");
      System.out.println("upaction bopen="+bopen);
      bdto.setBopen(bopen);
      bdto.setBnum(bnum);
      bdto.setBsubject(bsubject);
      bdto.setBcontent(bcontent);
      
      
      bdao.updateWebhard(bdto); // 제목, 내용, 게시판분류 업데이트
      
      /************************************/
      
      //파일영역
      
      
      
      
      String[] deletefiles = delfile.split(" "); //삭제할 파일들의 fnum
      
      List<String> filenames = new Vector<String>();
      
      for(int i = 0; i<deletefiles.length; i++){
         filenames.add(fdao.getFile(deletefiles[i]));            
   
      }

      List<String> etcnames = new Vector<String>();
      
   File delfolder = new File(realPath);
   
   while(delfolder.exists()) 
       {
         File[] folder_list = delfolder.listFiles(); //파일리스트 얻어오기
      
         for(int i=0; i<filenames.size(); i++){
         
         for (int j = 0; j < folder_list.length; j++) {
            
            if(filenames.get(i).equals(folder_list[j].getName())){
         
               folder_list[j].delete(); //파일 삭제 
               System.out.println("파일이 삭제되었습니다.");
               
            }
         }
            
         }
         break;
      }
      
      
   for(int i=0; i<deletefiles.length; i++){
      fdao.deleteFile(deletefiles[i]);
   }
   
   fdao.deleteCommuGetFilelist(bnum);
   
      //넣은 파일의 이름 구하기
         File dirFile = new File(realPath);//저장된 폴더 파일 객체 
         
         File[] fileList = dirFile.listFiles(); //저장된 폴더의 파일들
         
         for (File tempFile : fileList) { // 저장된 폴더의 파일들의 이름 구하기
            if (tempFile.isFile()) {//파일이 있다면
               String tempPath = tempFile.getParent(); //저장된 폴더
               
               String tempFileName = tempFile.getName();
               
               FileDto fdto = new FileDto();
               fdto.setNum(num);
               fdto.setBnum(bnum);
               fdto.setFilename(tempFileName);
               fdao.insertFiles(fdto);
            }
         
         }
   
   
   
   System.out.println("sd");
   response.sendRedirect("webhard_updateaction2.jsp?bnum="+bnum+"&pageNum="+pageNum);
   
   }catch(Exception e){
      e.printStackTrace();
   }
   
%>