package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.BoardDto;
import oracle.db.DbConnect;

public class MyPageDao {

	DbConnect db = new DbConnect();
	Connection conn=null;
	PreparedStatement pstmt=null;
	Statement stmt=null;
	ResultSet rs=null;
	
	//목록출력
	public List<BoardDto> getAllAdminBoard(String num,String category,String searchtxt, int start, int end)
	   {
	      List<BoardDto> list = new Vector<BoardDto>();
	      String sql = "";
	    
	     if(num==null) {
	    	 if(searchtxt==null||searchtxt.equals("")||searchtxt.length()==0) {
	    		 sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board order by bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;	    	 
	    		 
	    	 }else {
	    		 sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where "+category+" like '%"+searchtxt+"%' order by bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;	    	 
	    	 }	    	 
	     }else {
	    	 if(searchtxt==null||searchtxt.equals("")||searchtxt.length()==0) {
	    		 sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where num= "+num+" order by bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;	    	 
	    		 
	    	 }else {
	    		 sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where num= "+num+" and "+category+" like '%"+searchtxt+"%' order by bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;	    	 
	    	 }	
	     }
	      
	      
	     
	     conn=db.getConnection();
	      
	      try {
	         stmt=conn.createStatement();
	         
	         rs=stmt.executeQuery(sql);
	         
	         while(rs.next())
	         {
	            BoardDto dto= new BoardDto();
	            dto.setBnum(rs.getString("bnum"));
	            dto.setBnotice(rs.getInt("bnotice"));
	            dto.setBsubject(rs.getString("bsubject"));
	            dto.setBcontent(rs.getString("bcontent"));
	            dto.setNum(rs.getString("num"));
	            dto.setBreadcount(rs.getInt("breadcount"));
	            dto.setBlike(rs.getInt("blike"));
	            dto.setBopen(rs.getString("bopen"));
	            dto.setBwriteday(rs.getTimestamp("bwriteday"));
	            dto.setBcommu(rs.getString("bcommu"));
	            dto.setBoardtype(rs.getInt("boardtype"));
	            
	            
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
	//게시글 삭제
	public void deleteAdminBoard(String bnum)
	   {
	      String sql="delete from board where bnum=?";
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
	
	//데이터 가져오기
	public BoardDto getAdminBoard(String bnum)
	   {
	      BoardDto dto=new BoardDto();
	      String sql="select * from board where bnum="+bnum;
	      conn=db.getConnection();

	      try {
	         stmt=conn.createStatement();
	         //실행
	         rs=stmt.executeQuery(sql);
	         
	         if(rs.next())
	         {
	            dto.setBnum(rs.getString("bnum"));
	            dto.setBnotice(rs.getInt("bnotice"));
	            dto.setBsubject(rs.getString("bsubject"));
	            dto.setBcontent(rs.getString("bcontent"));
	            dto.setNum(rs.getString("num"));
	            dto.setBreadcount(rs.getInt("breadcount"));
	            dto.setBlike(rs.getInt("blike"));
	            dto.setBopen(rs.getString("bopen"));
	            dto.setBwriteday(rs.getTimestamp("bwriteday"));
	            dto.setBcommu(rs.getString("bcommu"));
	            dto.setBoardtype(rs.getInt("boardtype"));
	            
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
	public void updateNotice(BoardDto dto)
    {
       String sql="update board set bsubject=?,bcontent=? where bnum=?";
       
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
	
	public int getMyBoardTotalCount(String category, String searchtxt,String num) {
		int myboardCount = 0;
		conn = db.getConnection();
		String sql = "";
		
		if(num==null) {
			if(searchtxt==null||searchtxt.length()==0||searchtxt.equals("")) {
				sql = "select count(*) from board";
			}else {
				sql = "select count(*) from board where "+category+" like '%"+searchtxt+"%'";
			}
			
		}else {
			if(searchtxt==null||searchtxt.length()==0||searchtxt.equals("")) {
				sql = "select count(*) from board where num = "+num;			
			}else {
				sql = "select count(*) from board where num = "+num+" and "+category+" like '%"+searchtxt+"%'";
			}
			
		}
		
		
		try {
			stmt=conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				myboardCount = rs.getInt(1);
			}
		
		} catch (SQLException e) {
			System.out.println("getMyBoardTotalCount 에러 :"+e.getMessage());
			e.printStackTrace();
		}
		System.out.println(myboardCount);
		return myboardCount;
	}
	
}

