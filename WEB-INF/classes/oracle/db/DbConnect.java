package oracle.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnect {
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:xe";

	public DbConnect() {
		// TODO Auto-generated constructor stub
		try {
			Class.forName(driver);
			//System.out.println("����̹� ����");
		} catch (ClassNotFoundException e) {
			System.out.println("����̹� ����:"+e.getMessage());
		}
	}

	//����Ŭ ������ connection �� ��ȯ�ϴ� �޼���
	public Connection getConnection()
	{
		
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(url, "intranet", "1234");
			//System.out.println("����Ŭ ���� ����");
		} catch (SQLException e) {
			System.out.println("����Ŭ ���� ����:"+e.getMessage());
		}
		return conn;
	}
	

	//sql �ڿ����� �ݴ� �޼���
	public void dbClose(PreparedStatement pstmt,Connection conn)
	{
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dbClose(ResultSet rs,PreparedStatement pstmt,Connection conn)
	{
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose(Statement stmt,Connection conn)
	{
		try {
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void dbClose(ResultSet rs,Statement stmt,Connection conn)
	{
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
