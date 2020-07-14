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

import gamedori.beans.dto.GameListDto;

public class GameListDao {

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
	
	// 최신 게임 top 100
	public List<GameListDto> getLatestList(int topN) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM ("
				+ "SELECT rownum rn, a.* FROM ("
				+ "SELECT * FROM game_list ORDER BY GAME_DATE DESC"
				+ ")a"
				+ ") WHERE rn BETWEEN 1 AND ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, topN);
		ResultSet rs = ps.executeQuery();
		List<GameListDto> list = new ArrayList<GameListDto>();
		while(rs.next()) {
			GameListDto gldto = new GameListDto(rs);
			list.add(gldto);
		}
		
		con.close();
		return list;
	}
	
	public List<GameListDto> getTodayList(int start, int finish) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM ("
				+ "SELECT rownum rn, g.* FROM game_list g "
				+ "WHERE TO_char(GAME_DATE, 'yyyyMMdd') - TO_char(SYSDATE, 'yyyyMMdd') = 0"
				+ ")a "
				+ "WHERE rn BETWEEN ? AND ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, finish);
		ResultSet rs = ps.executeQuery();
		List<GameListDto> list = new ArrayList<GameListDto>();
		while(rs.next()) {
			GameListDto gldto = new GameListDto(rs);
			list.add(gldto);
		}
		
		con.close();
		return list;
	}
	
	public int getTodayCount() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT count(*) FROM game_list WHERE TO_char(GAME_DATE, 'yyyyMMdd') - TO_char(SYSDATE, 'yyyyMMdd') = 0";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		con.close();
		
		return count;
	}
	
	
}
