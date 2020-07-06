package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
			Context env = (Context)ctx.lookup("java:/comp/env");
			src = (DataSource)env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 연결 메소드
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		return src.getConnection();
	}//로그인
	public MemberDto login(MemberDto mdto) throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT * FROM member WHERE member_id=? AND member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_pw());
		ResultSet rs = ps.executeQuery();
		MemberDto user;
		if(rs.next()) {
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
		}
		else {
			user = null;
		}
		
		con.close();
		
		return user;
	}
//로그인 시간
	public void updateLoginTime(int no) throws Exception{
		Connection con = getConnection();
		
		String sql = "UPDATE member SET member_login_date=sysdate WHERE member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, no);
		ps.execute();

		
		con.close();
	}
	//아이디 찾기 메소드
	public String findId(MemberDto mdto) throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT member_id FROM member "
				+ "WHERE member_name=? and member_phone=? and member_nick=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_name());
		ps.setString(2, mdto.getMember_phone());
		ps.setString(3, mdto.getMember_nick());
		ResultSet rs = ps.executeQuery();
		

		String member_id;
		if(rs.next()) {
			member_id = rs.getString("member_id");//rs.getString(1)
		}
		else {
			member_id = null;
		}
		
		con.close();
		
		return member_id;
	}
	//비밃번호 찾기 메소드
	public String findPw(MemberDto mdto) throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT member_pw FROM member "
				+ "WHERE member_id=? and member_phone=? and member_name=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_phone());
		ps.setString(3, mdto.getMember_name());
		ResultSet rs = ps.executeQuery();
		

		String member_pw;
		if(rs.next()) {
			member_pw = rs.getString("member_pw");
		}
		else {
			member_pw = null;
		}
		
		con.close();
		
		return member_pw;
	}


			// 가입 메소드
			public void join(MemberDto mdto) throws Exception {
				Connection con = getConnection();

				String sql = "INSERT INTO member VALUES(member_seq.nextval, ?, ?, ?, ?, ?, '일반',0, sysdate, null)";
				PreparedStatement ps = con.prepareStatement(sql);

				ps.setString(1, mdto.getMember_name());
				ps.setString(2, mdto.getMember_id());
				ps.setString(3, mdto.getMember_pw());
				ps.setString(4, mdto.getMember_nick());
				ps.setString(5, mdto.getMember_phone());

				ps.execute();

				con.close();
			}

	
}
