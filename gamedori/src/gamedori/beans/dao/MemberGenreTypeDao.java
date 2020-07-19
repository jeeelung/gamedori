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

import gamedori.beans.dto.MemberGenreTypeDto;

public class MemberGenreTypeDao {

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
	
	// 관심분야 추출 메소드
	public List<MemberGenreTypeDto> getFavorite(int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM member_genre_type WHERE member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		List<MemberGenreTypeDto> list = new ArrayList<MemberGenreTypeDto>();
		while(rs.next()) {
			MemberGenreTypeDto mgtdto = new MemberGenreTypeDto();
			mgtdto.setMember_no(rs.getInt("member_no"));
			mgtdto.setGenre_type(rs.getString("genre_type"));
			mgtdto.setGenre_no(rs.getInt("genre_no"));
			
			list.add(mgtdto);
		}
		con.close();
		return list;
	}
	
}
