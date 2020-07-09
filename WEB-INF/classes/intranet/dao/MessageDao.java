package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.MessageDto;
import oracle.db.DbConnect;

public class MessageDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public int getMainCount(String num) {
		int count = 0;
		conn = db.getConnection();
		String sql = "select count(*) from message where mreader = ? and checks = 0";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("getMainCount 에러 : " +e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
				
		return count;
	}
	
	public void updateChecks(String mnum) {
		conn=db.getConnection();
		String sql ="update message set checks=1 where mnum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mnum);
			
			pstmt.execute();
		
		} catch (SQLException e) {
			System.out.println("updateChecks 에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	
	}
	
	
	public void deleteMessage(String mnum) {
		conn=db.getConnection();
		
		String sql = "delete from message where mnum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mnum);
			
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("deleteMessage 에러 :"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public void updateReaderDel(String mnum) {
		
		conn=db.getConnection();
		
		String sql = "update message set mreaderdel=1 where mnum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mnum);
			
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("updateReaderDel 에러 :"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public void updateWriterDel(String mnum) {
		
		conn=db.getConnection();
		
		String sql = "update message set mwriterdel=1 where mnum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mnum);
			
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("updateWriterdel 에러 :"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public MessageDto getMessage(String mnum) {
		MessageDto msdto = new MessageDto();
		
		conn=db.getConnection();
		String sql = "select * from message where mnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				msdto.setMnum(rs.getString("mnum"));
				msdto.setMwriter(rs.getString("mwriter"));
				msdto.setMreader(rs.getString("mreader"));
				msdto.setMcontent(rs.getString("mcontent"));
				
				msdto.setMwriterdel(rs.getString("mwriterdel"));
				msdto.setMreaderdel(rs.getString("mreaderdel"));
				
				msdto.setMwriteday(rs.getTimestamp("mwriteday"));
				msdto.setChecks(rs.getString("checks"));
			}
		
		} catch (SQLException e) {
			System.out.println("getMessage 에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return msdto;
	}
	
	public void insertMessage(MessageDto mdto) {
		
		conn = db.getConnection();
		String sql = "insert into message values (seq_intra.nextval,?,?,?,0,0,sysdate,0)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mdto.getMwriter());
			pstmt.setString(2, mdto.getMreader());
			pstmt.setString(3, mdto.getMcontent());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insertMessage에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public int getFromMessageCount(String deltype, String user, String category,String searchtxt, String num) {
		int frommessagecount = 0;
		
		conn = db.getConnection();
		String sql = "";
		
		if(searchtxt==null||searchtxt.equals("")||searchtxt.length()==0) {
			sql = "select count(*) from message where "+user+" = "+num+" and "+deltype+"=0";
			
		}else {
			sql = "select count(*) from message where "+user+" = "+num+" and "+deltype+"=0 and "+category+" like '%"+searchtxt+"%'";
		}
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		
			if(rs.next()) {
				frommessagecount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getFromMessageCount 에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
		
		
		return frommessagecount;
	}
	
	public List<MessageDto> getFromMessageList(String user, String category,String searchtxt, int start, int end,String num){
		conn = db.getConnection();
		System.out.println("dao user:"+user);
		List<MessageDto> mslist = new Vector<MessageDto>();
		String sql ="";
		if(searchtxt==null||searchtxt.equals("")||searchtxt.length()==0) {
			sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from message where "+user+" = "+num+" order by mwriteday desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;			
			
		}else {
			sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from message where "+user+" = "+num+" and "+category+" like "+"'%"+searchtxt+"%'"+" order by mwriteday desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;			
		}
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				MessageDto msdto = new MessageDto();
				msdto.setMnum(rs.getString("mnum"));
				msdto.setMwriter(rs.getString("mwriter"));
				msdto.setMreader(rs.getString("mreader"));
				msdto.setMcontent(rs.getString("mcontent"));
				msdto.setMwriteday(rs.getTimestamp("mwriteday"));
				
				msdto.setMwriterdel(rs.getString("mwriterdel"));
				msdto.setMreaderdel(rs.getString("mreaderdel"));
				msdto.setChecks(rs.getString("checks"));
				System.out.println("medto.mcontent="+msdto.getMcontent());
				
				mslist.add(msdto);
			}
		
		} catch (SQLException e) {
			System.out.println("getFromMessageList");
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
		
		
		return mslist;
	}
	
}
