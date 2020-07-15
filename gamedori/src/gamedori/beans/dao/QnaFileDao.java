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

import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.QnaFileDto;

public class QnaFileDao {
	
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
	public void save(QnaFileDto qfdto) throws Exception{
		Connection con = getConnection();
		String sql = "INSERT INTO Qna_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qfdto.getQna_no());
		ps.setInt(2, qfdto.getFile_no());
		ps.execute();
		
		con.close();
	}
	
	public List<FilesDto> getList(int qna_no) throws Exception{
		Connection con = getConnection();
		String sql = "SELECT f.* "
				+ "FROM files f INNER JOIN Qna_file q "
				+ "ON q.file_no = f.file_no "
				+ "WHERE q.qna_no = ? "
				+ "ORDER BY f.file_no ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qna_no);
		ResultSet rs = ps.executeQuery();
		List<FilesDto> list = new ArrayList<FilesDto>();
		while(rs.next()) {
			FilesDto fdto = new FilesDto(rs);
			list.add(fdto);
		}
		con.close();
		return list;
	}
	public void delete(int qna_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM qna_file WHERE qna_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qna_no);
		ps.execute();
		con.close();
	}
	
	public void deleteFile(int file_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM qna_file WHERE file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ps.execute();
		con.close();
	}
	
	// 게시물에 해당하는 파일 번호 전부 가져오기
	public List<Integer> getfileNo(int qna_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT file_no FROM qna_file WHERE qna_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, qna_no);
		
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