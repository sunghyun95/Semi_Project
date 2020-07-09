package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.NoticeDto;
import oracle.db.DbConnect;

public class NoticeDao {
   DbConnect db = new DbConnect();
   Connection conn=null;
   PreparedStatement pstmt=null;
   Statement stmt=null;
   ResultSet rs=null;
   String sql="";
   
   //추가
   public void insertNotice(NoticeDto dto)
   {
      conn=db.getConnection();
      sql="insert into board values(seq_intra.nextval,1,0,?,?,?,0,0,0,sysdate,'공지사항')";                
      
      try {
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, dto.getBsubject());
         pstmt.setString(2, dto.getBcontent());
         pstmt.setString(3, dto.getNum());
         
         pstmt.execute();
         
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      finally
      {
         db.dbClose(pstmt, conn);
      }
   }
   //목록출력
   public List<NoticeDto> getAllNotice(String category, String searchtxt,int start, int end)
   {
      List<NoticeDto> list = new Vector<NoticeDto>();
      
      if(searchtxt==null||searchtxt.equals("")) {
    	  sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 1 order by bnotice desc,bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
     }else {
       	  sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 1 and "+category+" like '%"+searchtxt+"%' order by bnotice desc,bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
       	 
      }

      conn=db.getConnection();
      
      try {
         stmt=conn.createStatement();
         rs=stmt.executeQuery(sql);
         
         while(rs.next())
         {
            NoticeDto dto= new NoticeDto();
            dto.setBnum(rs.getString("bnum"));
            dto.setBnotice(rs.getString("bnotice"));
            dto.setBsubject(rs.getString("bsubject"));
            dto.setBcontent(rs.getString("bcontent"));
            dto.setNum(rs.getString("num"));
            dto.setBreadcount(rs.getString("breadcount"));
            dto.setBlike(rs.getString("blike"));
            dto.setBopen(rs.getString("bopen"));
            dto.setBwriteday(rs.getTimestamp("bwriteday"));
            dto.setBcommu(rs.getString("bcommu"));
            dto.setBoardtype(rs.getString("boardtype"));
            
            
            list.add(dto);
            
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally
      {
         db.dbClose(rs, stmt, conn);
      }
      
      return list;
   }
   
   
   //데이터 가져오기
     public NoticeDto getData(String bnum)
   {
      NoticeDto dto=new NoticeDto();
      sql="select * from board where boardtype=1 and bnum="+bnum;
      conn=db.getConnection();

      try {
         stmt=conn.createStatement();
         //실행
         rs=stmt.executeQuery(sql);
         
         if(rs.next())
         {
            dto.setBnum(rs.getString("bnum"));
            dto.setBnotice(rs.getString("bnotice"));
            dto.setBsubject(rs.getString("bsubject"));
            dto.setBcontent(rs.getString("bcontent"));
            dto.setNum(rs.getString("num"));
            dto.setBreadcount(rs.getString("breadcount"));
            dto.setBlike(rs.getString("blike"));
            dto.setBopen(rs.getString("bopen"));
            dto.setBwriteday(rs.getTimestamp("bwriteday"));
            dto.setBcommu(rs.getString("bcommu"));
            dto.setBoardtype(rs.getString("boardtype"));
            
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         db.dbClose(rs,stmt, conn);
      }
      return dto;
   }
     
     
     //수정
    public void updateNotice(NoticeDto dto)
    {
       sql="update board set bsubject=?,bcontent=? where bnum=?";
       
       try {
          conn=db.getConnection();
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, dto.getBsubject());
         pstmt.setString(2, dto.getBcontent());
         pstmt.setString(3, dto.getBnum());
         
         pstmt.execute();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
       finally
       {
          db.dbClose(pstmt, conn);
       }
    }
   //삭제
   public void deleteNotice(String bnum)
   {
      sql="delete from board where bnum=?";
      conn=db.getConnection();

      try {
         pstmt=conn.prepareStatement(sql);
         //바인딩
         pstmt.setString(1,bnum);
         
         //실행
         pstmt.execute();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         db.dbClose(pstmt, conn);
      }
   }
   
   //bnotice 1로 바꿔주는 메서드
     public void upBnotice(String bnum)
     {
        sql="update board set bnotice=1 where bnum=?";
        
        conn=db.getConnection();
        try {
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, bnum);
         
         pstmt.execute();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally
        {
         db.dbClose(pstmt, conn);
        }
     }
     
   
   //가장 최근글 글번호 구하기
   
   public String getMaxBnum()
   {
      String maxbnum = "";
      String sql = "select max(bnum) from board where boardtype=1";
      
      conn=db.getConnection();
      
      try {
         pstmt=conn.prepareStatement(sql);   
         //실행
         rs=pstmt.executeQuery();
         
         if(rs.next())
         {
            maxbnum=rs.getString(1);
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         db.dbClose(rs,pstmt, conn);
      }
      
      return maxbnum;
   }
   
   public int getNoticeTotalCount(String category, String searchtxt) {
	   int totalcount = 0;
	   
	   conn = db.getConnection();
	   if(searchtxt==null||searchtxt.equals("")) {
		   sql = "select count(*) from board where boardtype=1";
	   }else {
		   sql = "select count(*) from board where boardtype=1 and "+category+" like '%"+searchtxt+"%'";
	   }
	   try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			totalcount = rs.getInt(1);
		}
	   
	   } catch (SQLException e) {
		   System.out.println("getNoticeTotalCount 에러 : "+e.getMessage());
		e.printStackTrace();
	}finally {
		db.dbClose(rs, stmt, conn);
	}
	   
	   return totalcount;   
   }
   
   public void updateNoticeReadCount(String bnum) {
	   
	   conn = db.getConnection();
	   
	   String sql = "update board set breadcount=breadcount+1 where bnum = ?";
	   
	   try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, bnum);
		
		pstmt.execute();
	   } catch (SQLException e) {
		   System.out.println("updateNoticeReadCount 에러 : "+e.getMessage());
		e.printStackTrace();
	}finally {
		db.dbClose(pstmt, conn);
	}
	   
   }
}