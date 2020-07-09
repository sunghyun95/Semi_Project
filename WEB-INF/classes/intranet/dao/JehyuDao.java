package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.JehyuDto;
import oracle.db.DbConnect;

public class JehyuDao {
   DbConnect db = new DbConnect();
   Connection conn=null;
   PreparedStatement pstmt=null;
   Statement stmt=null;
   ResultSet rs= null;
   String sql="";
   
   public void insertJehyu(JehyuDto dto)
   {
      sql="insert into jehyu values (seq_intra.nextval,?,?,?,?,?,sysdate,'0')";
       
      conn=db.getConnection();
      try {
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, dto.getJhname());
         pstmt.setString(2, dto.getJhaddr());
         pstmt.setString(3, dto.getJhcontent());
         pstmt.setString(4, dto.getWido());
         pstmt.setString(5, dto.getGyungdo());
         
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
   
   public List<JehyuDto> getAllJehyu()
   {
      String sql="";
      List<JehyuDto> list=new Vector<JehyuDto>();
      
      conn=db.getConnection();
      sql="select * from jehyu order by num asc";
      
      try {
         stmt=conn.createStatement();
         rs=stmt.executeQuery(sql);
         
         while(rs.next())
         {
            JehyuDto dto= new JehyuDto();
            
            dto.setNum(rs.getString("num"));
            dto.setJhname(rs.getString("jhname"));
            dto.setJhaddr(rs.getString("jhaddr"));
            dto.setJhcontent(rs.getString("jhcontent"));
            dto.setWido(rs.getString("wido"));
            dto.setGyungdo(rs.getString("gyungdo"));
            dto.setWriteday(rs.getTimestamp("writeday"));
            
            list.add(dto);
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      finally
      {
         db.dbClose(rs, stmt, conn);
      }
      
      return list;
   }
   
   public void deleteJehyu(String num)
   {
      sql="delete from jehyu where num=?";
      conn=db.getConnection();
      try {
         pstmt=conn.prepareStatement(sql);
         //바인딩
         pstmt.setString(1,num);
         
         //실행
         pstmt.execute();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         db.dbClose(pstmt, conn);
      }
   }
}