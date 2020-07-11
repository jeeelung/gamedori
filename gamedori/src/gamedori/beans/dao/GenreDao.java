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
import gamedori.beans.dto.QnaDto;
import gamedori.beans.dto.QnaFileDto;

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
	
	
	public List<GenreDto> getList() throws Exception{
		Connection con = getConnection();
		String sql = "select *from genre ";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		List<GenreDto> list = new ArrayList<>();
		while(rs.next()) {
			GenreDto gdto = new GenreDto(rs);
			list.add(gdto);
		}
		
		con.close();
		return list;
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

		String sql = "UPDATE qna SET " + "genre_no=?, genre_type=? where genre_no=?";
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
