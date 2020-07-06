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
	}
	
	// 정보 수정 메소드
	public void changeInfo(MemberDto mdto) throws Exception{
		Connection con = getConnection();
		
		String sql = "UPDATE member "
				+ "SET member_pw = ?, member_nick = ?, member_phone = ? "
				+ "WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_pw());
		ps.setString(2, mdto.getMember_nick());
		ps.setString(3, mdto.getMember_phone());
		ps.setString(4, mdto.getMember_id());
		
		ps.execute();
		
		con.close();
	}
	
	// 비밀번호 변경 메소드
	public void changePw(MemberDto mdto) throws Exception {
		Connection con = getConnection();
		String sql = "UPDATE member "
				+ "Set member_pw = ? "
				+ "WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_pw());
		ps.setString(2, mdto.getMember_id());
		
		ps.execute();
		
		con.close();
	}
	
}
