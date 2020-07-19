package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.GameFileDto;

public class GameFileDao {

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
	public void save(GameFileDto gfdto) throws Exception {
		Connection con = getConnection();
		String sql = "INSERT INTO game_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, gfdto.getGame_no());
		ps.setInt(2, gfdto.getFile_no());
		ps.execute();
		con.close();
	}
	
	public int getFileNo(int game_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT file_no FROM game_file WHERE game_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, game_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int file_no = rs.getInt(1);
		con.close();
		return file_no;
	}
	
	public void delete(int game_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM GAME_FILE WHERE GAME_NO = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, game_no);
		ps.execute();
		con.close();		
	}
	
}
