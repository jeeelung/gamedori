package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.GameImgDto;
import oracle.jdbc.proxy.annotation.Pre;

public class GameImgDao {

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
	
	// 시퀀스 꺼내는 메소드
	public int getSequence() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT game_img_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		
		return seq;
	}
	
	// 이미지 정보 업로드 메소드
		public void save(GameImgDto gidto) throws Exception{
			Connection con = getConnection();
			String sql = "INSERT INTO game_img values(?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, gidto.getGame_no());
			ps.setInt(2, gidto.getGame_img_no());
			ps.setString(3, gidto.getGame_img_name());
			ps.setString(4, gidto.getGame_img_type());
			ps.setLong(5, gidto.getGame_img_size());
			
			ps.execute();
			
			con.close();
		}
		public GameImgDto get(int game_img_no) throws Exception {
			Connection con = getConnection();
			String sql = "SELECT * FROM game_img WHERE game_img_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, game_img_no);
			ResultSet rs = ps.executeQuery();
			
			GameImgDto gidto = rs.next()? new GameImgDto(rs): null;
			con.close();
			return gidto;
		}
		
		public void delete(int game_no) throws Exception {
			Connection con = getConnection();
			String sql = "DELETE FROM game_img WHERE game_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, game_no);
			ps.execute();
			con.close();
		}
		
		public int getGameImgNo(int game_no) throws Exception {
			Connection con = getConnection();
			String sql = "SELECT game_img_no FROM game_img WHERE game_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, game_no);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int game_img_no = rs.getInt(1);
			con.close();
			return game_img_no;
		}
}
