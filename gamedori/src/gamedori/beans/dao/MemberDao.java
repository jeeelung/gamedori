package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.MemberDto;

public class MemberDao {

	private static DataSource src;
	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// 연결 메소드
	public Connection getConnection() throws ClassNotFoundException, SQLException {
//		Class.forName("oracle.jdbc.OracleDriver");
//		return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##gamedori", "c##gamedori");
		return src.getConnection();
	}

	// 로그인
	public MemberDto login(MemberDto mdto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_pw());
		ResultSet rs = ps.executeQuery();
		MemberDto user;
		if (rs.next()) {
			user = new MemberDto();
			user.setMember_no(rs.getInt("member_no"));
			user.setMember_name(rs.getString("member_name"));
			user.setMember_id(rs.getString("member_id"));
			user.setMember_pw(rs.getString("member_pw"));
			user.setMember_nick(rs.getString("member_nick"));
			user.setMember_phone(rs.getString("member_phone"));
			user.setMember_auth(rs.getString("member_auth"));
			user.setMember_point(rs.getInt("member_point"));
			user.setMember_join_date(rs.getString("member_join_date"));
			user.setMember_login_date(rs.getString("member_login_date"));
		} else {
			user = null;
		}
		con.close();

		return user;
	}
	public String  overlapID(MemberDto mdto) throws Exception{
		Connection con = getConnection();
		String sql ="select member_id from member where member_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_id());
		ResultSet rs = ps.executeQuery();
		String member_id;
		if (rs.next()) {
			member_id = rs.getString("member_id");// rs.getString(1)
		} else {
			member_id = null;
		}
		con.close();
		return member_id;
	}
	public String overlapNick(MemberDto mdto) throws Exception{
		Connection con = getConnection();
		String sql = "select member_nick from member where member_nick=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_nick());
		ResultSet rs = ps.executeQuery();
		String member_nick;
		if(rs.next()) {
			member_nick = rs.getString("member_nick");
		} else {
			member_nick = null;
		}
		con.close();
		return member_nick;
	}
	// 로그인 시간 메소드
	public void updateLoginTime(int no) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE member SET member_login_date=sysdate WHERE member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ps.execute();

		con.close();
	}

	// 아이디 찾기 메소드
	public String findId(MemberDto mdto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT member_id FROM member " + " WHERE member_name = ? and member_phone = ?";
//					
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_name());
		ps.setString(2, mdto.getMember_phone());
		ResultSet rs = ps.executeQuery();

//			String member_id = 추출한 아이디 or null;
		String member_id;

		if (rs.next()) {
			member_id = rs.getString("member_id");// rs.getString(1)
		} else {
			member_id = null;
		}

		con.close();
		return member_id;
	}

	// 비밀번호 찾기 메소드
	public String findPw(MemberDto mdto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT member_pw FROM member " + "WHERE member_id = ? and member_phone = ? and member_name=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_phone());
		ps.setString(3, mdto.getMember_name());
		ResultSet rs = ps.executeQuery();

		String member_pw;
		if (rs.next()) {
			member_pw = rs.getString("member_pw");
		} else {
			member_pw = null;
		}

		con.close();

		return member_pw;
	}

	// 가입 메소드
	public void join(MemberDto mdto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO member VALUES(?, ?, ?, ?, ?, ?, '일반',0, sysdate, null)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, mdto.getMember_no());
		ps.setString(2, mdto.getMember_name());
		ps.setString(3, mdto.getMember_id());
		ps.setString(4, mdto.getMember_pw());
		ps.setString(5, mdto.getMember_nick());
		ps.setString(6, mdto.getMember_phone());

	

		ps.execute();

		con.close();
	}
	public int getMember_no() throws Exception{
		Connection con = getConnection();

		String sql = "SELECT CAST(member_seq.nextval as NUMBER) as member_no  FROM DUAL";
		PreparedStatement ps = con.prepareStatement(sql);
		int result = 0;
		
		ResultSet rs =ps.executeQuery();
		if(rs.next()) {
			result =rs.getInt(1); 
		}
		con.close();
		
		return result;
		
	}
	// 정보 수정 메소드
	public void changeInfo(MemberDto mdto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE member SET member_pw = ?, member_nick = ?, member_phone = ? WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_pw());
		ps.setString(2, mdto.getMember_nick());
		ps.setString(3, mdto.getMember_phone());
		ps.setString(4, mdto.getMember_id());

		ps.execute();

		con.close();
	}

	// 단일 조회 메소드
	public MemberDto get(String member_id) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM member WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_id);
		ResultSet rs = ps.executeQuery();

		MemberDto mdto;
		if (rs.next()) {
			mdto = new MemberDto(rs);
		} else {
			mdto = null;
		}
		con.close();
		return mdto;
	}

	// 비밀번호 변경 메소드
	public void changePw(MemberDto mdto) throws Exception {
		Connection con = getConnection();
		String sql = "UPDATE member " + "Set member_pw = ? " + "WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_pw());
		ps.setString(2, mdto.getMember_id());

		ps.execute();

		con.close();
	}

	// 단일 조회 메소드
	public MemberDto get(int member_no) throws Exception {
		Connection con = getConnection();

		String sql = "select * from member where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();

		MemberDto mdto;
		if (rs.next()) {
			mdto = new MemberDto();

			mdto.setMember_no(rs.getInt("member_no"));
			mdto.setMember_name(rs.getString("member_name"));
			mdto.setMember_id(rs.getString("member_id"));
			mdto.setMember_pw(rs.getString("member_pw"));
			mdto.setMember_nick(rs.getString("member_nick"));
			mdto.setMember_phone(rs.getString("member_phone"));
			mdto.setMember_auth(rs.getString("member_auth"));
			mdto.setMember_point(rs.getInt("member_point"));
			mdto.setMember_join_date(rs.getString("member_join_date"));
			mdto.setMember_login_date(rs.getString("member_login_date"));

		} else {
			mdto = null;
		}
		con.close();
		return mdto;
	}

	// 탈퇴 메소드
	public void exit(int member_no) throws Exception {
		Connection con = getConnection();

		String sql = "delete member where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ps.execute();

		con.close();
	}
	
	//멤버 리스트 메소드
	
	public List<MemberDto> list(int start, int finish) throws Exception{
		Connection con = getConnection();
		
		String sql= "SELECT * FROM (SELECT ROWNUM rn, A.* FROM MEMBER A) B WHERE rn BETWEEN ? AND ?";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, finish);
		ResultSet rs=ps.executeQuery();
		
		List<MemberDto> list = new ArrayList<>();
		while(rs.next()) {
			MemberDto mdto = new MemberDto(rs);
			list.add(mdto);
		}
		con.close();
		return list;
	}
	//(관리자) 회원 검색 기능(타입 추가) - 메소드 오버로딩
			public List<MemberDto> search(String type, String keyword,int start,int finish) throws Exception{
				Connection con = getConnection();
				
				String sql = "SELECT * FROM(SELECT ROWNUM rn, T.* FROM(SELECT * FROM member WHERE (instr(#1, ?) > 0 ) )T ) WHERE rn BETWEEN ? and ?";
									
				sql = sql.replace("#1", type);
				
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, keyword);
				ps.setInt(2, start);
				ps.setInt(3, finish);
				ResultSet rs = ps.executeQuery();
				
				//나머지 처리는 다른 목록들과 동일하다
				List<MemberDto> list = new ArrayList<>();
				while(rs.next()) {
					MemberDto mdto = new MemberDto(rs);
					list.add(mdto);
				}
				
				con.close();
				
				return list;
			}
	
			//개수 조회 메소드
			public int getCount() throws Exception{
				Connection con = getConnection();
				String sql="select count(*) from member";

				PreparedStatement ps=con.prepareStatement(sql);
				ResultSet rs= ps.executeQuery();
				rs.next();
				int count =rs.getInt(1); //또는 rs.getInt ("count(*)");
				
				con.close();
				return count;
			}
			
			public int getCount(String type,String keyword) throws Exception{
				Connection con = getConnection();
				String sql = "SELECT count (*)  FROM member "
						+ "WHERE instr(#1, ?) > 0 "
						+ "order by member_no desc";
						
				sql = sql.replace("#1", type);
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, keyword);
				
				ResultSet rs= ps.executeQuery();
				rs.next();
				int count = rs.getInt(1); //또는 rs.getInt("count(*));
				
				con.close();
				return count;
				
			}
}


