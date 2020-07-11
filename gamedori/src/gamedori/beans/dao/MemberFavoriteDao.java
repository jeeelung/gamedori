package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.MemberFavoriteDto;

public class MemberFavoriteDao {
	
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
	// 등록
		public void choice(MemberFavoriteDto mfdto) throws Exception {
			Connection con = getConnection();
			String sql = "INSERT INTO MemberFavorite VALUES(?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, mfdto.getMemberFavorite_no());
			ps.setInt(2, mfdto.getGenre_no());
			ps.setInt(3, mfdto.getMember_no());
			ps.execute();

			con.close();
		}

		//  수정
		public void edit(MemberFavoriteDto mfdto) throws Exception {
			Connection con = getConnection();

			String sql = "UPDATE MemberFavorite SET " + "MemberFavorite_no=?, genre_no=?,member_no where MemberFavorite_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, mfdto.getMemberFavorite_no());
			ps.setInt(2, mfdto.getGenre_no());
			ps.setInt(3, mfdto.getMember_no());
			ps.execute();

			con.close();
		}

		// 삭제
		public void delete(int MemberFavorite_no) throws Exception {
			Connection con = getConnection();

			String sql = "DELETE MemberFavorite WHERE MemberFavorite_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, MemberFavorite_no);
			ps.execute();

			con.close();
		}
	
	

}
