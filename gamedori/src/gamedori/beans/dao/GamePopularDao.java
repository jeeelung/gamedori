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

import gamedori.beans.dto.GamePopularDto;

public class GamePopularDao {
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
	
	// 인기게임 추출 메소드	
	public List<GamePopularDto> getList(int topN, int start, int finish) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM ("
				+ "SELECT * FROM ("
				+ "SELECT rownum rn, a.* FROM ("
				+ "SELECT * FROM game_popular "
				+ ")a"
				+ ") WHERE rn BETWEEN 1 AND ?"
				+ ") WHERE rn BETWEEN ? AND ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, topN);
		ps.setInt(2, start);
		ps.setInt(3, finish);
		ResultSet rs = ps.executeQuery();
		List<GamePopularDto> list = new ArrayList<GamePopularDto>();
		while(rs.next()) {
			GamePopularDto gpdto = new GamePopularDto(rs);
			gpdto.setRow_num(rs.getInt("rn"));
			list.add(gpdto);
		}
		con.close();
		return list;
	}
	
	public List<GamePopularDto> getFavorite(int genre_no, int topN) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM ("
				+ "SELECT rownum rn, a.* FROM ("
				+ "SELECT * FROM game_popular "
				+ "WHERE genre_no = ? "
				+ ")a"
				+ ") WHERE rn BETWEEN 1 AND ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genre_no);
		ps.setInt(2, topN);
		ResultSet rs = ps.executeQuery();
		List<GamePopularDto> list = new ArrayList<GamePopularDto>();
		while(rs.next()) {
			GamePopularDto gpdto = new GamePopularDto(rs);
			gpdto.setRow_num(rs.getInt("rn"));
			list.add(gpdto);
		}
		con.close();
		return list;
	}
	
}
