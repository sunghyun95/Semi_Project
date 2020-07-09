package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.ReplyDto;
import oracle.db.DbConnect;

public class ReplyDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public void insertReply(ReplyDto rdto) {
		
		conn = db.getConnection();
		String sql = "insert into reply values (seq_intra.nextval,?,?,?,sysdate)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rdto.getBnum());
			pstmt.setString(2, rdto.getNum());
			pstmt.setString(3, rdto.getRcontent());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insertReply 에러 :" + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public int getReplyCount(String bnum) {
		int replyCount = 0;
		conn = db.getConnection();
		
		String sql = "select count(*) from reply where bnum = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bnum);
			
			if(rs.next()) {
				replyCount = rs.getInt(1);
				
			}
		
		} catch (SQLException e) {
			System.out.println("getReplyCount 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		
		return replyCount;
		
	}
	
	public List<ReplyDto> getReplyAllData(String bnum)
	{
		List<ReplyDto> rlist = new Vector<ReplyDto>();
		conn = db.getConnection();
		String sql = "select * from reply where bnum = "+bnum+" order by rnum desc";
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				ReplyDto rdto = new ReplyDto();
				
				rdto.setRnum(rs.getString("rnum"));
				rdto.setBnum(rs.getString("bnum"));
				rdto.setNum(rs.getString("num"));
				rdto.setRcontent(rs.getString("rcontent"));
				rdto.setRwriteday(rs.getTimestamp("rwriteday"));
				
				rlist.add(rdto);
			}
		
		} catch (SQLException e) {
			System.out.println("getReplyAllData 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
		return rlist;
	}
	
	public void deleteReply(String rnum) {
		
		conn = db.getConnection();
		String sql = "delete from reply where rnum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rnum);

			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("deleteReply 에러 :"+ e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public void updateReply(ReplyDto rdto) {
		conn = db.getConnection();
		String sql = "update reply set rcontent=? where rnum = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rdto.getRcontent());
			pstmt.setString(2, rdto.getRnum());
			
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("updateReply 에러 :"+e.getMessage() );
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
}