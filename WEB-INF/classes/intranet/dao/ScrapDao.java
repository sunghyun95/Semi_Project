package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.ScrapDto;
import oracle.db.DbConnect;

public class ScrapDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public int getScrapCount(String category,String searchtxt,String num) {
		int scraptype = 0;
		conn=db.getConnection();
		String sql="";
		if(searchtxt.length()==0||searchtxt.equals("")||searchtxt==null) {
		sql = "select count(*) from scrap where num ="+num;
		}else {
			sql = "select count(*) from scrap where num="+num+" and "+category+" like '%"+searchtxt+"%'";
		}
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			if(rs.next())
			{
				scraptype=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		  
		
		return scraptype;
	}
	
	public int getScrapType(String bnum,String num) {
		int scraptype = 0;
		conn=db.getConnection();
		String sql = "select count(*) from scrap where bnum=? and num =?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			pstmt.setString(2, num);
			
			
			rs = pstmt.executeQuery();
		
			if(rs.next())
			{
				scraptype=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		  
		
		return scraptype;
	}
	
	public void insertScrap(String bnum, String num) {
		
		conn = db.getConnection();
		String sql = "insert into scrap values (seq_intra.nextval,?,?,sysdate)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, bnum);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insertScrap 에러 : "+e.getMessage());
			e.printStackTrace();
		}db.dbClose(pstmt, conn);
		
	}
	
	public List<ScrapDto> myscrapList(String category, String searchtxt, int start, int end,String num){
		conn=db.getConnection();
		List<ScrapDto> list=new Vector<ScrapDto>();
		String sql = "";
		if(searchtxt==null||searchtxt.length()==0||searchtxt.equals("")) {
        sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from scrap where num="+num+" order by snum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
		

		}else {
	        sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from scrap where num="+num+"  and "+category+" like '%"+searchtxt+"%' order by snum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;

		}
		try {
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				ScrapDto sdto=new ScrapDto();
				sdto.setSnum(rs.getString("snum"));
				sdto.setNum(rs.getString("num"));
				sdto.setBnum(rs.getString("bnum"));
				sdto.setSwriteday(rs.getTimestamp("writeday"));
				
				list.add(sdto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		return list;
	}
	
	public void deleteScrap(String bnum,String num) {
		conn = db.getConnection();
		String sql = "delete from scrap where num=? and bnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, bnum);
			
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("deleteScrap 에러 : "+e.getMessage());
			e.printStackTrace();
		}db.dbClose(pstmt, conn);
		
	}
	
	public ScrapDto getScrapdto(String bnum)
	{
		ScrapDto sdto=new ScrapDto();
		String sql="select * from scrap where bnum="+bnum;
		conn=db.getConnection();
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				sdto.setSnum(rs.getString("snum"));
				sdto.setBnum(rs.getString("bnum"));
				sdto.setNum(rs.getString("num"));
				sdto.setSwriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		return sdto;
	}
	
	public void deleteScraps(String Bnum) {
		conn = db.getConnection();
		String sql = "delete from scrap where Bnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Bnum);
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("deleteScraps 에러 : "+e.getMessage());
			e.printStackTrace();
		}db.dbClose(pstmt, conn);
		
	}
}
