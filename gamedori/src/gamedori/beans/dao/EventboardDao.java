package gamedori.beans.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


import gamedori.beans.dto.EventboardDto;
import gamedori.beans.dto.MemberDto;







public class EventboardDao {

	//context.xml에서 관리하는 자원 객체를 참조할 수 있도록 연결 코드 구현
	private static DataSource src;//리모컨 선언
	
	//static 변수의 초기화가 복잡할 경우에 사용할 수 있는 static 전용 구문
	static {
		try {
			//src = context.xml에서 관리하는 자원의 정보;
			Context ctx = new InitialContext();//탐색 도구
			Context env = (Context) ctx.lookup("java:/comp/env");//Context 설정 탐색
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		return src.getConnection();
	}
	
	// event_no 추출 메소드
	public int getSequence() throws Exception{
		Connection con = getConnection();
		String sql = "SELECT event_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	// 게시물 단일 조회 메소드
	public EventboardDto get(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM event WHERE event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		
		EventboardDto edto = rs.next()? new EventboardDto(rs): null;
		con.close();
		
		return edto;
	}
	
	// 게시물 등록 메소드
	public void write(EventboardDto edto) throws Exception{
		if(edto.getSuper_no() == 0) {
			edto.setGroup_no(edto.getEvent_no());
		} else {
			EventboardDto find = this.get(edto.getSuper_no());
			edto.setGroup_no(find.getGroup_no());
			edto.setDepth(find.getDepth()+1);
		}
		
		Connection con = getConnection();
		String sql = "INSERT INTO event"
				+ "("
				+ "event_no, "
				+ "member_no, "
				+ "event_title, "
				+ "event_content, "
				+ "event_super_no, "
				+ "event_group_no, "
				+ "event_depth"
				+ ") "
				+ "value(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, edto.getEvent_no());
		ps.setInt(2, edto.getMember_no());
		
		ps.setString(3, edto.getEvent_title());
		ps.setString(4, edto.getEvent_content());
		
		if(edto.getSuper_no() == 0) {
			ps.setNull(5, Types.INTEGER);
		} else {
			ps.setInt(5, edto.getSuper_no());
		}
		ps.setInt(6, edto.getGroup_no());
		ps.setInt(7, edto.getDepth());
		ps.execute();
		con.close();
	}
	
	// 작성자 메소드
	public MemberDto getWriter(int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT m.* "
				+ "FROM member m INNER JOIN event e "
				+ "ON m.member_no = e.member_no "
				+ "WHERE e.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		MemberDto mdto = rs.next()? new MemberDto(rs): null;
		
		con.close();
		
		return mdto;
	}
	// 리스트
	public List<EventboardDto> getList() throws Exception{
		Connection con = getConnection();
		
		String sql = "SELECT * FROM event ORDER BY event_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<EventboardDto> list = new ArrayList<>();
		while(rs.next()) {
			EventboardDto edto = new EventboardDto(rs);
			list.add(edto);
		}
		
		con.close();
		return list;
	}
	//게시글 수정
		public void edit(EventboardDto edto) throws Exception {
			Connection con = getConnection();
			
			String sql = "UPDATE event SET "
								+ "event_title=?, event_content=? "
								+ "where event_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, edto.getEvent_title());
			ps.setString(2, edto.getEvent_content());
			ps.setInt(3, edto.getEvent_no());
			ps.execute();
			
			con.close();
		}
		public void plusReadcount(int event_no, int member_no) throws Exception {
			Connection con = getConnection();
			
			String sql = "UPDATE event "
							+ "SET event_read = event_read + 1 "
							+ "WHERE event_no = ? and member_no != ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, event_no);
			ps.setInt(2, member_no);
			ps.execute();
			
			con.close();
		}
		//게시글 삭제
		public void delete(int event_no) throws Exception {
			Connection con = getConnection();

			String sql = "DELETE event WHERE event_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, event_no);
			ps.execute();
			
			con.close();
		}
		
		
}