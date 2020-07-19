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
	
	// 장르명 추출
	public String getType(int genre_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT genre_type FROM genre WHERE gerne_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genre_no);
		ResultSet rs = ps.executeQuery();
		String genre_type = rs.next()? rs.getString(1): null;
		con.close();
		return genre_type;
	}
	
	// 장르 개수 추출
	public int getCount() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT Count(*) FROM genre";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		int count = rs.next()? rs.getInt(1): null;
		con.close();
		return count;
	}
	
	// 등록
	public void choice(GenreDto gdto) throws Exception {
		Connection con = getConnection();
		String sql = "INSERT INTO Genre VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, gdto.getGenre_no());
		ps.setString(2, gdto.getGenre_type());
		ps.execute();

		con.close();
	}

	// 장르 수정
	public void edit(GenreDto gdto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE qna SET genre_no=?, genre_type=? where genre_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, gdto.getGenre_no());
		ps.setString(2, gdto.getGenre_type());
		ps.execute();

		con.close();
	}

	// 삭제
	public void delete(int genre_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE genre WHERE genre_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genre_no);
		ps.execute();

		con.close();
	}
}

