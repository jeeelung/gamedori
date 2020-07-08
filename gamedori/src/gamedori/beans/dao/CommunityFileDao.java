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
	
	public List<FilesDto> getList(int commu_no) throws Exception{
		Connection con = getConnection();
		String sql = "SELECT f.* "
				+ "FROM files f INNER JOIN Community_file c "
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
}
