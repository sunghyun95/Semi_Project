package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.BoardDto;
import intranet.dto.MemberDto;
import oracle.db.DbConnect;


public class BoardDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public void updateLikes(String bnum, int likes) {
		
		conn=db.getConnection();
		String sql = "update board set blike=? where bnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, likes);
			pstmt.setString(2, bnum);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public List<BoardDto> getAllboard(){
		List<BoardDto> list = new Vector<BoardDto>();
		conn=db.getConnection();
		String sql = "select * from board where boardtype=5";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				BoardDto dto = new BoardDto();
				dto.setBnum(rs.getString("bnum"));
				dto.setBoardtype(rs.getInt("boardtype"));
				dto.setBsubject(rs.getString("bsubject"));
				dto.setBcontent(rs.getString("bcontent"));
				dto.setBreadcount(rs.getInt("breadcount"));
				dto.setBlike(rs.getInt("blike"));
				dto.setBopen(rs.getString("bopen"));
				dto.setBwriteday(rs.getTimestamp("bwriteday"));
				dto.setBcommu(rs.getString("bcommu"));
				dto.setNum(rs.getString("num"));
				
				
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("getAllboard 에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return list;
	
	}
	 
	public int getCommuTotalCount(String bopen,String category, String searchtxt)
	{
		int totalcount = 0;
		conn = db.getConnection();
		String sql = "";
		
		
		if(searchtxt == null || searchtxt.equals("") || searchtxt.equals("null")) {
			sql = "select count(*) from board where boardtype=5 and bopen="+bopen;
		}else {			
			sql = "select count(*) from board where boardtype=5 and bopen= "+bopen+" and "+category+" like '%"+searchtxt+"%'";
		}
	
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalcount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("totalcount 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return totalcount;
		
	}
	
	//private folder count 출력
	public int getPrivateTotalCount(String bopen,String category, String searchtxt,String num)
	{
		int totalcount = 0;
		conn = db.getConnection();
		String sql = "";
		
		
		if(searchtxt == null || searchtxt.equals("") || searchtxt.equals("null")) {
			sql = "select count(*) from board where boardtype=5 and bopen="+bopen+" and num ="+num;
		}else {			
			sql = "select count(*) from board where boardtype=5 and bopen= "+bopen+" and num = "+num+" and "+category+" like '%"+searchtxt+"%'";
		}
	
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalcount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("totalcount 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return totalcount;
		
	}
	
	
	
	
	

	//게시판 목록 출력 
	public List<BoardDto> getWebhardDatas(String bopen,String category , String searchtxt,String sort,int start, int end){
		List<BoardDto> list = new Vector<BoardDto>();
		String sql = "";
		conn = db.getConnection();
		
		
		if(searchtxt==null || searchtxt.equals("")||searchtxt.length()==0) //검색어가 없을때
		{
			if(sort==null|| sort.equals("")||sort.length()==0) {//정렬순이 없을때
				sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 5 and bopen= "+bopen+" order by bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
			}
			else {
				sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 5 and bopen="+bopen+" order by "+sort+" desc, bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
			}	
		}
			
		else { // 검색어가 있을때
			if(sort==null|| sort.equals("")||sort.length()==0) {//정렬순이 없을때
				sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 5 and bopen="+bopen+" and "+category+" like "+"'%"+searchtxt+"%'"+" order by bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
			}
			else {
				sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from board where boardtype = 5 and bopen="+bopen+" and "+category+" like "+"'%"+searchtxt+"%'"+" order by "+sort+" desc, bnum desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;
			}	
		}
		
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				BoardDto dto = new BoardDto();
				dto.setBnum(rs.getString("bnum"));
				dto.setBoardtype(rs.getInt("boardtype"));
				dto.setBsubject(rs.getString("bsubject"));
				dto.setBcontent(rs.getString("bcontent"));
				dto.setBreadcount(rs.getInt("breadcount"));
				dto.setBlike(rs.getInt("blike"));
				dto.setBopen(rs.getString("bopen"));
				dto.setBwriteday(rs.getTimestamp("bwriteday"));
				dto.setBcommu(rs.getString("bcommu"));
				dto.setNum(rs.getString("num"));
				
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("getWebhardDatas 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}

		return list;
	}
	
	  
	
	//게시판 글작성
	public void insertWebhard(BoardDto dto) {
		conn = db.getConnection();
		String sql = "insert into board values (seq_intra.nextval,5,0,?,?,?,0,0,0,sysdate,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBsubject());
			pstmt.setString(2, dto.getBcontent());
			pstmt.setString(3, dto.getNum());
			pstmt.setString(4, dto.getBcommu());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insertCommu 에러 : "+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}	
	}
	
	//max(bnum)값 구하기
	public int getWebhardMaxBnum()
	{
		int bnum = 0;
		conn = db.getConnection();
		String sql = "select max(bnum) from board";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bnum = rs.getInt(1);
			}
		
		} catch (SQLException e) {
			System.out.println("getNaxBnum 에러 : "+e.getMessage());
			e.printStackTrace();
 		}finally {
 			db.dbClose(rs, pstmt, conn);
 		}
		
		return bnum;
	}
	 
	public void updateWebhard(BoardDto dto) {
		
		conn = db.getConnection();
		
		String sql = "update board set bsubject=?,bcontent=?,bopen=? where bnum = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBsubject());
			pstmt.setString(2, dto.getBcontent());
			pstmt.setString(3, dto.getBopen());
			pstmt.setString(4, dto.getBnum());
			pstmt.execute();
			
			
		} catch (SQLException e) {
			System.out.println("updateWebhard 에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
			
		}
		
		
	}
	
	 
	public BoardDto getWebHardData(String bnum) {
		BoardDto dto = new BoardDto();
		conn = db.getConnection();
		String sql = "select * from board where bnum = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				dto.setBnum(rs.getString("bnum"));
				dto.setBoardtype(rs.getInt("boardtype"));
				dto.setBsubject(rs.getString("bsubject"));
				dto.setBcontent(rs.getString("bcontent"));
				dto.setBreadcount(rs.getInt("breadcount"));
				dto.setBlike(rs.getInt("blike"));
				dto.setBwriteday(rs.getTimestamp("bwriteday"));
				dto.setBcommu(rs.getString("bcommu"));
				dto.setNum(rs.getString("num"));
				dto.setBopen(rs.getString("bopen"));
				 
			}
			
		} catch (SQLException e) {
			System.out.println("getCommuData 에러 : "+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
	
		 
		return dto;
	}
	
	public void deleteCommu(String bnum) {
		conn = db.getConnection();
		String sql = "delete from board where bnum = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			
			pstmt.execute();
		
		} catch (SQLException e) {
			System.out.println("deleteCommu 에러 : "+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public void updateWebHardReadcount(String bnum)
	{
		conn = db.getConnection();
		String sql ="update board set breadcount = breadcount+1 where bnum = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("updateReadcount 에러 : "+ e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//각 사원의 게시글 수 구하기
	public int getBoardTotalCount(String num) {
	
		int totalcount = 0;
		conn=db.getConnection();
		String sql= "select count(*) from board where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalcount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("getCommuTotalCount 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally
		{
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return totalcount;
	}
	  
	
}
