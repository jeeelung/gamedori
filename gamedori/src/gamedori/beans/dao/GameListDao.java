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
	public List<GameListDto> getNewList(int topN, int start, int finish) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM ("
				+ "SELECT * FROM ("
				+ "SELECT rownum rn, a.* FROM ("
				+ "SELECT * FROM game_list ORDER BY GAME_DATE DESC"
				+ ")a"
				+ ") WHERE rn BETWEEN 1 AND ?"
				+ ") WHERE rn BETWEEN ? AND ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, topN);
		ps.setInt(2, start);
		ps.setInt(3, finish);
		ResultSet rs = ps.executeQuery();
		List<GameListDto> list = new ArrayList<GameListDto>();
		while(rs.next()) {
			GameListDto gldto = new GameListDto(rs);
			gldto.setRow_num(rs.getInt("rn"));
			list.add(gldto);
		}
		
		con.close();
		return list;
	}
	
	// 오늘 업로드 된 게임 리스트
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
	
	// 오늘 업로드 된 게임 개수
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
	
	// 전체 게임 리스트
	public List<GameListDto> getList(String arrow) throws Exception {
		Connection con = getConnection();
		String sql = null;
		boolean isGameRead = arrow.equals("game_read");
		if(isGameRead) {
			sql = "SELECT * FROM game_popular ORDER BY "+arrow+" desc";
		}
		if(!isGameRead){			
			sql = "SELECT * FROM game_list ORDER BY game_date "+arrow+"";
		}
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		List<GameListDto> list = new ArrayList<GameListDto>();
		while(rs.next()) {
			GameListDto gldto = new GameListDto(rs);
			list.add(gldto);
		}
		con.close();
		return list;
	}
	
	// 장르별 게임 리스트
	public List<GameListDto> getGenreList(int genre_no, String arrow) throws Exception {
		Connection con = getConnection();
		String sql = null;
		boolean isGameRead = arrow.equals("game_read");
		if(isGameRead) {
			sql = "SELECT * FROM game_popular WHERE genre_no = ? ORDER BY "+arrow+"";
		}
		if(!isGameRead){			
			sql = "SELECT * FROM game_list WHERE genre_no = ? ORDER BY game_date "+arrow+"";
		}
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genre_no);
		ResultSet rs = ps.executeQuery();
		List<GameListDto> list = new ArrayList<GameListDto>();
		while(rs.next()) {
			GameListDto gldto = new GameListDto(rs);
			list.add(gldto);
		}
		
		con.close();
		return list;
	}
	
	
}
