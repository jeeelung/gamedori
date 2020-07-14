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

import gamedori.beans.dto.GenreDto;

public class GenreDao {

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
	
	// 장르 리스트 메소드
	public List<GenreDto> getList() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM genre";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<GenreDto> list = new ArrayList<GenreDto>();
		while(rs.next()) {
			GenreDto gdto = new GenreDto();
			gdto.setGenre_no(rs.getInt("genre_no"));
			gdto.setGenre_type(rs.getString("genre_type"));
			
			list.add(gdto);
		}
		con.close();
		return list;
	}
}
