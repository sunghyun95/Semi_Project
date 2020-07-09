package intranet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import intranet.dto.FileDto;
import oracle.db.DbConnect;

public class FileDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	//�Խñ� �߰��Ҷ� ���� �߰��ϱ�
	public void insertFiles(FileDto fdto) {
		
		conn = db.getConnection();
		String sql = "insert into files values (seq_intra.nextval,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fdto.getNum());
			pstmt.setString(2, fdto.getBnum());
			pstmt.setString(3, fdto.getFilename());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			System.out.println("insertFiles ���� : "+e.getMessage());
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	
	//�ش� �Խñ��� ÷�ε� ���� ��� ��������
	public List<FileDto> getCommuGetFilelist(String bnum){
		
		List<FileDto> flist = new Vector<FileDto>();
		
		conn = db.getConnection();
		String sql = "select * from files where bnum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				FileDto fdto = new FileDto();
				fdto.setFnum(rs.getString("fnum"));
				fdto.setBnum(rs.getString("bnum"));
				fdto.setFilename(rs.getString("filename"));
				fdto.setNum(rs.getString("num"));
				
				flist.add(fdto);
			}
			
		
		} catch (SQLException e) {
			System.out.println("getCommuGetFilelist ���� : "+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return flist;
	}
	
	public void deleteCommuGetFilelist(String bnum) {
		conn = db.getConnection();
		
		String sql = "delete from files where bnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bnum);
			pstmt.execute();
		
		} catch (SQLException e) {
			System.out.println("deleteCommuGetFilelist ���� :" + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	
	public void deleteFile(String fnum) {
		
		conn = db.getConnection();
		String sql = "delete from files where fnum = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fnum);
			
			pstmt.execute();
		
		} catch (SQLException e) {
			System.out.println("deleteFile ���� :" + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	
	
	public String getFile(String fnum) {
		conn=db.getConnection();
		String filename = "";
		String sql = "select filename from files where fnum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,fnum);
			  
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				filename = rs.getString(1);
			}
		} catch (SQLException e) {
			System.out.println("getFile ���� :" + e.getMessage());
			e.printStackTrace();
		}
		
		return filename;
	}
	
	
	//�����ͼ���
	public FileDto getNumFiles(String num)
	{
		FileDto dto=new FileDto();
		conn=db.getConnection();
		String sql="select * from files where bnum=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				dto.setFnum(rs.getString("fnum"));
				dto.setNum(rs.getString("num"));
				dto.setBnum(rs.getString("bnum"));
				dto.setFilename(rs.getString("filename"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("file select sql:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	//���� ����
	//����
    public void deleteBnumFile(String bnum)
    {
       conn=db.getConnection();
       String sql="delete from files where bnum=?";
       
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
    
    //����
	//����
	public void deleteFiles(String num)
	{
		String sql="delete from files where bnum=?";
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
    
	//����
	public void updateFiles(FileDto dto)
	{
		conn=db.getConnection();
		String sql="update files set filename=? where bnum=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getFilename());
			pstmt.setString(2, dto.getBnum());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
    
  //���� ��������
    public FileDto getBnumFile(String bnum)
    {
       FileDto dto=new FileDto();
       String sql="select * from files where bnum=?";
       conn=db.getConnection();
       
       try {
       pstmt=conn.prepareStatement(sql);
       pstmt.setString(1, bnum);
       rs=pstmt.executeQuery();
       
       if(rs.next())
       {
          dto.setFnum(rs.getString("fnum"));
          dto.setNum(rs.getString("num"));
          dto.setBnum(rs.getString("bnum"));
          dto.setFilename(rs.getString("filename"));   
       }
    } catch (SQLException e) {
       // TODO Auto-generated catch block
       e.printStackTrace();
    }finally
       {
       db.dbClose(rs, pstmt, conn);
       }
       return dto;
    }
    ///
    
    
    //����
  //���
  	public List<FileDto> filesList()
  	{
  		List<FileDto> list=new Vector<FileDto>();
  		conn=db.getConnection();
  		String sql="select * from files order by num";
  		try {
  			pstmt=conn.prepareStatement(sql);
  			rs=pstmt.executeQuery();
  			while(rs.next())
  			{
  				FileDto dto=new FileDto();
  				dto.setFnum(rs.getString("fnum"));
  				dto.setBnum(rs.getString("bnum"));
  				dto.setNum(rs.getString("num"));
  				dto.setFilename(rs.getString("filename"));
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
}
