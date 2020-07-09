package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import intranet.dto.LikesDto;
import oracle.db.DbConnect;

public class LikesDao {
	DbConnect db=new DbConnect();
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql="";
	
	//�߰�
	public void insertLikes(String bnum, String num)
	{
		sql="insert into likes values (seq_intra.nextval,?,?)";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			pstmt.setString(2, num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//���ƿ�Ŭ��
	public int getLikes(String bnum,String num)
	{
		conn=db.getConnection();
		sql="select count(*) from likes where bnum=? and num=?";
		int likes=0;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			pstmt.setString(2, num);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				likes=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("likes sql="+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return likes;
	}
	//���ƿ� 
		public int likesList(String bnum)
		{
			conn=db.getConnection();
			sql="select count(*) from likes where bnum=?";
			int likescnt=0;
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, bnum);
				rs=pstmt.executeQuery();
				if(rs.next())
				{
					likescnt=rs.getInt(1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("likes sql="+e.getMessage());
				e.printStackTrace();
			}finally {
				db.dbClose(rs, pstmt, conn);
			}
			
			return likescnt;
		}
	
	
	
	//����
	public void deleteLikes(String bnum,String num) {
		conn = db.getConnection();
		String sql = "delete from likes where num=? and bnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, bnum);
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("deletelikes ���� : "+e.getMessage());
			e.printStackTrace();
		}db.dbClose(pstmt, conn);
		
	}
	
}
