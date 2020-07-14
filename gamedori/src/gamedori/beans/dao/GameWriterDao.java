package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.GameWriterDto;

public class GameWriterDao {
	
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
	
	// 단일 조회 메소드
	public GameWriterDto get(int game_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM game_writer WHERE game_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, game_no);
		ResultSet rs = ps.executeQuery();
		GameWriterDto gdto = rs.next()? new GameWriterDto(rs): null;
		con.close();
		return gdto;
	}
}
