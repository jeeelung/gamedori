package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gamedori.beans.dto.EventFileDto;
import gamedori.beans.dto.FilesDto;



public class EventFileDao {

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
	
	public Connection getConnection() throws Exception{
		return src.getConnection();
	}
	
	//시퀀스 생성 메소드
	public int getSequence() throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT event_file_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);//rs.getInt("NEXTVAL");
		
		con.close();
		
		return seq;
	}
	
	//저장 메소드
	// - 시퀀스 번호까지 이미 뽑혀 있으므로 자동 생성할 데이터가 없다
	public void save(EventFileDto efdto) throws Exception {
		Connection con = getConnection();
		
		String sql = "INSERT INTO event_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, efdto.getEvent_no());
		ps.setInt(2, efdto.getFile_no());
		
		ps.execute();
		
		con.close();
	}
	

	// 게시물 파일 정보 불러오는 메소드
	public List<FilesDto> getList(int event_no) throws Exception{
		Connection con = getConnection();
		String sql = "SELECT f.* "
				+ "FROM files f INNER JOIN event_file e "
				+ "ON e.file_no = f.file_no "
				+ "WHERE e.event_no = ? "
				+ "ORDER BY f.file_no ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		List<FilesDto> list = new ArrayList<FilesDto>();
		while(rs.next()) {
			FilesDto fdto = new FilesDto(rs);
			list.add(fdto);
		}
		con.close();
		return list;
	}
	
	public void delete(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM event WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ps.execute();
		con.close();
	}
	
	public void deletefile(int file_no) throws Exception {
		Connection con = getConnection();
		String sql = "DELETE FROM event_file WHERE file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, file_no);
		ps.execute();
		con.close();
	}
	
	// 게시물에 해당하는 파일 번호 전부 가져오기
	public List<Integer> getfileNo(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT file_no FROM event_file WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		
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