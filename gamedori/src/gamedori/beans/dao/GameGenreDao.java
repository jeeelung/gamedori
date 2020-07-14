package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.GameGenreDto;
import oracle.jdbc.proxy.annotation.Pre;

public class GameGenreDao {
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
	
	// 등록 메소드
	public void write(GameGenreDto ggdto) throws Exception {
		Connection con = getConnection();
		String sql = "INSERT INTO game_genre VALUES (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, ggdto.getGame_genre_no());
		ps.setInt(2, ggdto.getGenre_no());
		ps.setInt(3, ggdto.getGame_no());
		ps.execute();
		
		con.close();
	}
	
	// 시퀀스 추출 메소드
	public int getSeq() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT game_genre_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		con.close();
		return seq;
	}
}
