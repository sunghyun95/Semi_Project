package intranet.dao;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import intranet.dto.MemberDto;
import oracle.db.DbConnect;

public class MemberDao {
	DbConnect db = new DbConnect();
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt =  null;
	ResultSet rs = null;
	
		
	
	public List<Object> isLogin(String id, String pass) {
		List<Object> list = new Vector<Object>();
		boolean login = false;
		
		conn = db.getConnection();
		String sql = "select * from member where id = ? and pass = ?";
				
				
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				
				login = true;
				list.add(login);
				list.add(rs.getString("num"));
			}
			
		} catch (SQLException e) {
			System.out.println("isLogin 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//관리자 찾기
	public MemberDto getAdmin() {
		MemberDto mdto = new MemberDto();
		conn = db.getConnection();
		String sql = "select * from member where buseo = '관리자'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				mdto.setNum(rs.getString("num"));
				mdto.setName(rs.getString("name"));
				mdto.setId(rs.getString("id"));
				String[] email = rs.getString("email").split("@");
				
				mdto.setEmail1(email[0]);
				mdto.setEmail2(email[1]);
				
				String[] hp = rs.getString("hp").split("-");
				mdto.setHp1(hp[0]);
				mdto.setHp2(hp[1]);
				mdto.setHp3(hp[2]);
				
				mdto.setAddr1(rs.getString("addr1"));
				mdto.setAddr2(rs.getString("addr2"));
				mdto.setBirth(rs.getString("birth"));
				
				mdto.setBuseo(rs.getString("buseo"));
				mdto.setGrade(rs.getString("grade"));
				mdto.setIpsaday(rs.getString("ipsaday"));
				
				
				
			}
			
		} catch (SQLException e) {
			System.out.println("getAdmin에러:"+e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return mdto;
	}
	
	//데이터 선택
	public MemberDto getMember(String num) {
		MemberDto dto = new MemberDto();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member where num = ?";
		conn=db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				String []email=rs.getString("email").split("@");
				try {
					dto.setEmail1(email[0]);
					dto.setEmail2(email[1]);
				} catch (ArrayIndexOutOfBoundsException e) {
					// TODO: handle exception
					dto.setEmail1("");
					dto.setEmail2("");
				}
				dto.setAddr1(rs.getString("addr1"));
				dto.setAddr2(rs.getString("addr2"));
				dto.setBirth(rs.getString("birth"));
				String []hp=rs.getString("hp").split("-");
				dto.setHp1(hp[0]);
				dto.setHp2(hp[1]);
				dto.setHp3(hp[2]);
				dto.setBuseo(rs.getString("buseo"));
				dto.setGrade(rs.getString("grade"));
				dto.setIpsaday(rs.getString("ipsaday"));
				dto.setImage(rs.getString("image"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	public MemberDto getInfoCheckMember(String name,String hp,String email)
	{
		MemberDto dto = new MemberDto();
		
		conn = db.getConnection();
		String sql = "select * from member where name=? and hp=? and email=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, hp);
			pstmt.setString(3, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{	
				
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				String[] hparr = rs.getString("hp").split("-");
				
				dto.setHp1(hparr[0]);
				dto.setHp2(hparr[1]);
				dto.setHp3(hparr[2]);
				
				String[] emailarr = rs.getString("email").split("@");
				
				dto.setEmail1(emailarr[0]);
				dto.setEmail2(emailarr[1]);
				
				
			} 
			
		} catch (SQLException e) {
			System.out.println("getInfoCheckMember 에러 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		
		return dto;
	}
	
	//혜지>?<
	
		//추가
		public void insertMember(MemberDto dto)
			{

				conn=db.getConnection();
				String sql="insert into member values (seq_intra.nextval,?,?,?,?,?,?,?,?,?,?,?,?)";

				try {
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, dto.getId());
					pstmt.setString(2, dto.getName());
					pstmt.setString(3, dto.getPass());
					pstmt.setString(4, dto.getEmail1()+"@"+dto.getEmail2());
					pstmt.setString(5, dto.getAddr1());
					pstmt.setString(6, dto.getAddr2());
					pstmt.setString(7, dto.getBirth());
					pstmt.setString(8, dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3());
					pstmt.setString(9, dto.getBuseo());
					pstmt.setString(10, dto.getGrade());
					pstmt.setString(11, dto.getIpsaday());
					pstmt.setString(12, dto.getImage());
					pstmt.execute();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					db.dbClose(pstmt, conn);
				}
			}
		
		//목록 출력
		public List<MemberDto> memberlist(String category, String searchtxt, int start, int end)
		{
			String sql="";

			List<MemberDto> list=new Vector<MemberDto>();

			conn=db.getConnection();
			
			if(searchtxt==null||searchtxt.equals("")||searchtxt.length()==0) {
				sql="select * from member order by num desc";
				
			   	 sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from member order by num desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;	    	 
				  
			}else {
				sql = "select a.* from (select ROWNUM as RNUM,b.* from (select * from member where "+category+" like '%"+searchtxt+"%' order by num desc)b)a where a.RNUM>="+start+" and a.RNUM<="+end;	    	 
				  
			}
			
			try {
				stmt=conn.createStatement();
				
				
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					MemberDto dto=new MemberDto();
					dto.setNum(rs.getString("num"));
					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("name"));
					dto.setPass(rs.getString("pass"));
					String []email=rs.getString("email").split("@");
					try {
						dto.setEmail1(email[0]);
						dto.setEmail2(email[1]);
					} catch (ArrayIndexOutOfBoundsException e) {
						// TODO: handle exception
						dto.setEmail1("");
						dto.setEmail2("");
					}
				
					dto.setAddr1(rs.getString("addr1"));
					dto.setAddr2(rs.getString("addr2"));
					dto.setBirth(rs.getString("birth"));
					String []hp=rs.getString("hp").split("-");
					dto.setHp1(hp[0]);
					dto.setHp2(hp[1]);
					dto.setHp3(hp[2]);
					dto.setBuseo(rs.getString("buseo"));
					dto.setGrade(rs.getString("grade"));
					dto.setIpsaday(rs.getString("ipsaday"));
					dto.setImage(rs.getString("image"));
							
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(rs, stmt, conn);
			}

			return list;
		}
		
		//수정
		public void updateMember(MemberDto dto)
		{
			String sql = "update member set name=?,email=?,addr1=?,addr2=?, birth=?, "
					+ "hp=?, buseo=?, grade=?, ipsaday=?, image=? where num=?";
			conn=db.getConnection();
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getEmail1()+"@"+dto.getEmail2());
				pstmt.setString(3, dto.getAddr1());
				pstmt.setString(4, dto.getAddr2());
				pstmt.setString(5, dto.getBirth());
				pstmt.setString(6, dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3());
				pstmt.setString(7, dto.getBuseo());
				pstmt.setString(8, dto.getGrade());
				pstmt.setString(9, dto.getIpsaday());
				pstmt.setString(10, dto.getImage());
				pstmt.setString(11, dto.getNum());
				pstmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(pstmt, conn);
			}
		}
		
		//사원번호 , 패스워드 등록
		public void updateIdpass(MemberDto dto)
		{
			conn=db.getConnection();
			String sql="update member set id=?,pass=? where num=?";
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,dto.getId() );
				pstmt.setString(2, dto.getPass());
				pstmt.setString(3, dto.getNum());
				pstmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				db.dbClose(pstmt, conn);
			}
			
		}
		
		//삭제
		public void memberDelete(String num)
		{
			conn=db.getConnection();
			String sql="delete from member where num=?";
			
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
		
		public int memberlistCount(String category, String searchtxt) {
			int memberlistCount =0;
			
			conn=db.getConnection();
			String sql="";
			
			if(searchtxt==null||searchtxt.length()==0||searchtxt.equals("")) {
				sql = "select count(*) from member";
			}else {
				sql = "select count(*) from member where "+category+" like '%"+searchtxt+"%'";
			}
			
			try {
				stmt=conn.createStatement();
				
				rs = stmt.executeQuery(sql);
				
				if(rs.next()) {
					memberlistCount=rs.getInt(1);
				}
				
			} catch (SQLException e) {
				System.out.println("memberlistCount 에러 :"+e.getMessage());
				e.printStackTrace();
			}finally {
				db.dbClose(rs, stmt, conn);
			}
			
			
			return memberlistCount;
		}
		
		public List<MemberDto> getMemberList(){
			conn=db.getConnection();
			List<MemberDto> mlist = new Vector<MemberDto>();
			
			String sql = "select * from member order by buseo desc";
			
			try {
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next())
				{
					MemberDto mdto = new MemberDto();
					mdto.setNum(rs.getString("num"));
					mdto.setId(rs.getString("id"));
					mdto.setName(rs.getString("name"));
					mdto.setPass(rs.getString("pass"));
					String []email=rs.getString("email").split("@");
					try {
						mdto.setEmail1(email[0]);
						mdto.setEmail2(email[1]);
					} catch (ArrayIndexOutOfBoundsException e) {
						// TODO: handle exception
						mdto.setEmail1("");
						mdto.setEmail2("");
					}
				
					mdto.setAddr1(rs.getString("addr1"));
					mdto.setAddr2(rs.getString("addr2"));
					mdto.setBirth(rs.getString("birth"));
					String []hp=rs.getString("hp").split("-");
					mdto.setHp1(hp[0]);
					mdto.setHp2(hp[1]);
					mdto.setHp3(hp[2]);
					mdto.setBuseo(rs.getString("buseo"));
					mdto.setGrade(rs.getString("grade"));
					mdto.setIpsaday(rs.getString("ipsaday"));
					mdto.setImage(rs.getString("image"));
							
					mlist.add(mdto);
				}
			
			} catch (SQLException e) {
				System.out.println("getMemberList 에러:"+e.getMessage());
				e.printStackTrace();
			}finally {
				db.dbClose(rs, pstmt, conn);
			}
			
			return mlist;
			
			
		}
}
