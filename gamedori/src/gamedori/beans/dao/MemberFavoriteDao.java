package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sun.org.apache.xalan.internal.xsltc.compiler.Template;

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
			String sql = "INSERT INTO member_favorite VALUES(member_favorite_seq.nextval ,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, mfdto.getGenre_no());
			ps.setInt(2, mfdto.getMember_no());
			ps.execute();

			con.close();
		}

		//  수정
		public void edit(MemberFavoriteDto mfdto) throws Exception {
			Connection con = getConnection();

			String sql = "UPDATE member_favorite SET " + "MemberFavorite_no=?, genre_no=?,member_no where MemberFavorite_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, mfdto.getMemberFavorite_no());
			ps.setInt(2, mfdto.getGenre_no());
			ps.setInt(3, mfdto.getMember_no());
			ps.execute();

			con.close();
		}

		// 삭제
		public void delete(int member_no) throws Exception {
			Connection con = getConnection();

			String sql = "DELETE member_favorite WHERE member_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, member_no);
			ps.execute();

			con.close();
		}
		
		public List<Map<String,Object>>  getList(int member_no) throws Exception {
			
			List<Map<String,Object>> result = new ArrayList<>();
			Connection con = getConnection();

			String sql = "SELECT g.genre_no , g.genre_type, mf.member_favorite_no  from GENRE g LEFT JOIN MEMBER_FAVORITE MF ON g.GENRE_NO  = mf.GENRE_NO AND MF.MEMBER_NO =?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, member_no);
			
			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				Map<String, Object> temp = new HashMap<>();
				int genre_no = rs.getInt("genre_no");
				String  genre_type = rs.getString("genre_type");
				int member_favorite_no = rs.getInt("member_favorite_no");
				temp.put("genre_no", genre_no);
				temp.put("genre_type", genre_type);
				temp.put("member_favorite_no", member_favorite_no);
				
				result.add(temp);
			
			}				
			
			con.close();
			
			return result;
		}
	
	

}
