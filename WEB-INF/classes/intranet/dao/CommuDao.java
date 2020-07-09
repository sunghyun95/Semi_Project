package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.CommuDto;
import intranet.dto.FileDto;
import oracle.db.DbConnect;

public class CommuDao {
	DbConnect db=new DbConnect();
	Connection conn=null;
	PreparedStatement pstmt=null;
	Statement stmt = null;
	ResultSet rs=null;
	String sql="";
 
	//추가
	public void insertCommu(CommuDto dto)
	{
		conn=db.getConnection();
		sql="insert into board (bnum,boardtype,bsubject,bcontent,num,bwriteday,bcommu) values (seq_intra.nextval,6,?,?,?,sysdate,?)";

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBsubject());
			pstmt.setString(2, dto.getBcontent());
			pstmt.setString(3, dto.getNum());
			pstmt.setString(4, dto.getBcommu());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("commu insert sql:"+e.getMessage());
		}finally {
			db.dbClose(pstmt, conn);
		}
	}

	//출력
	public List<CommuDto> commuList(String category, String searchtxt, int start, int end)
	{
		List<CommuDto> list=new Vector<CommuDto>();
		conn=db.getConnection();
		
		 if(searchtxt==null||searchtxt.equals("")) {
	    	  sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 6 order by bnotice desc,bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
	     }else {
	       	  sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 6 and "+category+" like '%"+searchtxt+"%' order by bnotice desc,bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
	       	 
	      }
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				CommuDto dto=new CommuDto();
				dto.setBnum(rs.getString("bnum"));
				dto.setBoardtype(rs.getString("boardtype"));
				dto.setBsubject(rs.getString("bsubject"));
				dto.setBcontent(rs.getString("bcontent"));
				dto.setNum(rs.getString("num"));
				dto.setBreadcount(rs.getInt("breadcount"));
				dto.setBlike(rs.getInt("blike"));
				dto.setBwriteday(rs.getTimestamp("bwriteday"));
				dto.setBcommu(rs.getString("bcommu"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}

		return list;
	}
	
	//데이터 선택
	public CommuDto getCommu(String num)
	{
		CommuDto dto=new CommuDto();
		conn=db.getConnection();
		sql="select * from board where bnum=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				dto.setBnum(rs.getString("bnum"));
				dto.setBoardtype(rs.getString("boardtype"));
				dto.setBsubject(rs.getString("bsubject"));
				dto.setBcontent(rs.getString("bcontent"));
				dto.setNum(rs.getString("num"));
				dto.setBreadcount(rs.getInt("breadcount"));
				dto.setBlike(rs.getInt("blike"));
				dto.setBwriteday(rs.getTimestamp("bwriteday"));
				dto.setBcommu(rs.getString("bcommu"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	public String getMaxbnum() {
		String maxbnum = "";
		sql = "select max(bnum) from board";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				maxbnum=rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return maxbnum;
	}
	
	//삭제
	public void deleteCommu(String num)
	{
		sql="delete from board where bnum=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	//수정
	public void updateCommu(CommuDto dto)
	{
		conn=db.getConnection();
		sql="update board set bsubject=?,bcontent=?,bcommu=? where bnum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBsubject());
			pstmt.setString(2, dto.getBcontent());
			pstmt.setString(3, dto.getBcommu());
			pstmt.setString(4, dto.getBnum());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	//조회수증가
	
	public void updateReadcount(String bnum)
	{
		conn=db.getConnection();
		sql="update board set breadcount=breadcount+1 where bnum=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	

	
	//전체 게시글 수 구하기
	public int getCommuTotalCount(String category,String searchtxt) {
		
		
		int totalcount = 0;
		conn=db.getConnection();
		if(searchtxt==null||searchtxt.equals("")) {
			   sql = "select count(*) from board where boardtype=6";
		   }else {
			   sql = "select count(*) from board where boardtype=6 and "+category+" like '%"+searchtxt+"%'";
		   }
		try {
			stmt = conn.createStatement();
			System.out.println(searchtxt);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				totalcount = rs.getInt(1);
				System.out.println(totalcount);
			}
			
		} catch (SQLException e) {
			System.out.println("getCommuTotalCount 에러 : " + e.getMessage());
			e.printStackTrace();
		}
		
		
		return totalcount;
	}
}
