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

import gamedori.beans.dto.EventboardFileDto;


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
	public void save(EventboardFileDto efdto) throws Exception {
		Connection con = getConnection();
		
		String sql = "INSERT INTO event_file VALUES(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, efdto.getEvent_no());
		ps.setInt(2, efdto.getFile_no());
		
		ps.execute();
		
		con.close();
	}
	
	//게시글 첨부파일 조회(댓글 조회와 동일)
	public List<EventboardFileDto> getList(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM event_file "
							+ "WHERE file_no = ? "
							+ "ORDER BY event_no ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		List<EventboardFileDto> list = new ArrayList<>();
		while(rs.next()) {
			EventboardFileDto efdto = new EventboardFileDto(rs);
			list.add(efdto);
		}
		con.close();
		return list;
	}
	
	//단일조회 기능
	public EventboardFileDto get(int event_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT * FROM event_file WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		
		EventboardFileDto efdto;
		if(rs.next()) {
			efdto = new EventboardFileDto(rs);
		}
		else {
			efdto = null;
		}
		
		con.close();
		return efdto;
	}
}
	
	

