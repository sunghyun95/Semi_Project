package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.DiaryDto;
import oracle.db.DbConnect;

public class DiaryDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public void deleteDiary(String dnum) {
		conn = db.getConnection();
		
		String sql = "delete from diary where dnum = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dnum);
			
			pstmt.execute();
		
		} catch (SQLException e) {
			System.out.println("deleteDiary 에러 : "+ e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public DiaryDto getDiary(String dnum) {
		DiaryDto dto = new DiaryDto();
		
		conn = db.getConnection();
		
		String sql = "select * from diary where dnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				dto.setDnum(rs.getString("dnum"));
				dto.setNum(rs.getString("num"));
				dto.setStartdate(rs.getString("startdate"));
				dto.setEnddate(rs.getString("enddate"));
				dto.setDsubject(rs.getString("dsubject"));
				dto.setDcontent(rs.getString("dcontent"));
				dto.setDwriteday(rs.getTimestamp("dwriteday"));
				dto.setDiarytype(rs.getString("diarytype"));
				
			}
		
		} catch (SQLException e) {
			System.out.println("getDiary 에러 :"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return dto;
	}
	
	public void insertDiary(DiaryDto dto) {
		
		conn = db.getConnection();
		String sql = "insert into diary values (seq_intra.nextval,?,?,?,?,?,sysdate,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getStartdate());
			pstmt.setString(3, dto.getEnddate());
			pstmt.setString(4, dto.getDsubject());
			pstmt.setString(5, dto.getDcontent());
			pstmt.setString(6, dto.getDiarytype());
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insertDiary 에러:"+ e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public List<DiaryDto> getDiarylist(){
		
		List<DiaryDto> dlist = new Vector<DiaryDto>();
		
		conn = db.getConnection();
		
		String sql = "select * from diary";
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				DiaryDto dto = new DiaryDto();
				
				dto.setDnum(rs.getString("dnum"));
				dto.setNum(rs.getString("num"));
				dto.setStartdate(rs.getString("startdate"));
				dto.setEnddate(rs.getString("enddate"));
				dto.setDsubject(rs.getString("dsubject"));
				dto.setDcontent(rs.getString("dcontent"));
				dto.setDwriteday(rs.getTimestamp("dwriteday"));
				dto.setDiarytype(rs.getString("diarytype"));
				
				dlist.add(dto);
				
			}
		} catch (SQLException e) {
			System.out.println("getDiarylist 에러 :"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
	
		return dlist;
	}
}
