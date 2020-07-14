package gamedori.beans.dao;

import java.nio.file.Files;
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

import gamedori.beans.dto.CommunityFileDto;
import gamedori.beans.dto.FilesDto;

public class CommunityFileDao {
	
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
	public void save(CommunityFileDto cfdto) throws Exception{
		Connection con = getConnection();
		String sql = "INSERT INTO community_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, cfdto.getCommu_no());
		ps.setInt(2, cfdto.getFile_no());
		ps.execute();
		
		con.close();
	}
	
	// 게시물 파일 정보 불러오는 메소드
	public List<FilesDto> getList(int commu_no) throws Exception{
		Connection con = getConnection();
		String sql = "SELECT f.* "
				+ "FROM files f INNER JOIN community_file c "
				+ "ON c.file_no = f.file_no "
				+ "WHERE c.commu_no = ? "
				+ "ORDER BY f.file_no ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commu_no);
		ResultSet rs = ps.executeQuery();
		List<FilesDto> list = new ArrayList<FilesDto>();
		while(rs.next()) {
			FilesDto fdto = new FilesDto(rs);
			list.add(fdto);
		}
		con.close();
		return list;
	}
	
	public void delete(int commu_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM community_file WHERE commu_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commu_no);
		ps.execute();
		con.close();
	}
	
	public void deleteFile(int file_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM community_file WHERE file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ps.execute();
		con.close();
	}
	
	// 게시물에 해당하는 파일 번호 전부 가져오기
	public List<Integer> getfileNo(int commu_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT file_no FROM community_file WHERE commu_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commu_no);
		
		ResultSet rs = ps.executeQuery();
		List<Integer> list = new ArrayList<>();
		
		while(rs.next()) {
			int file_no = rs.getInt("file_no");
			
			list.add(file_no);
		}
		con.close();
		return list;
	}
	
	
}
