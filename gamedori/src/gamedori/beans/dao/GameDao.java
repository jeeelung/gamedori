package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.GameDto;

public class GameDao {

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
		return src.getConnection();
	}
	
	public int getSequence() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT game_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		con.close();
		return seq;
	}
	
	public void write(GameDto gdto) throws Exception {
		Connection con = getConnection();
		String sql = "INSERT INTO GAME("
				+ "game_no, "
				+ "member_no, "
				+ "game_name, "
				+ "game_intro"
				+ ") "
				+ "VALUES (?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, gdto.getGame_no());
		ps.setInt(2, gdto.getMember_no());
		ps.setString(3, gdto.getGame_name());
		ps.setString(4, gdto.getGame_intro());
		ps.execute();
		con.close();
	}
}
