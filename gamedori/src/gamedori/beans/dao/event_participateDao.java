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

import gamedori.beans.dto.EventFileDto;
import gamedori.beans.dto.EventboardDto;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.event_participateDto;

public class event_participateDao {

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

	// 회원 포인트
	public MemberDto getPoint(int member_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT m.* " + "FROM member m INNER JOIN event_partici e " + "ON m.member_no = e.member_no "
				+ "WHERE e.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();

		MemberDto mdto = rs.next() ? new MemberDto(rs) : null;

		con.close();

		return mdto;
	}

	// 이벤트번호와 회원번호로 단일 조회 쿼리
	public List<event_participateDto> eventSearch(int member_no, int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM event_partici WHERE member_no = ? AND event_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ps.setInt(2, event_no);

		ResultSet rs = ps.executeQuery();

		List<event_participateDto> list = new ArrayList<event_participateDto>();

		while (rs.next()) {
			event_participateDto epdto = new event_participateDto(rs);
			list.add(epdto);
		}

		con.close();
		return list;
	}

	// 응모하게 될 시 insert문
	public void EventInfo(event_participateDto epdto) throws Exception {

		Connection con = getConnection();
		String sql = "INSERT INTO event_partici VALUES (event_partici_seq.nextval, ?, ?, SYSDATE)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, epdto.getMember_no());
		ps.setInt(2, epdto.getEvent_no());

		ps.execute();
		
		con.close();
	}

	// 응모내역 DELETE문
	public void deleteEvent(event_participateDto epdto) throws Exception {

		Connection con = getConnection();
		String sql = "DELETE FROM event_partici WHERE member_no =? and event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, epdto.getMember_no());
		ps.setInt(2, epdto.getEvent_no());

		ps.execute();
		con.close();
	}

	public int getSequence() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT event_partici_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int seq = rs.getInt(1);

		con.close();
		return seq;
	}

	// 이벤트 참여
	public EventboardDto ejoin(int event_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT e.* FROM event e INNER JOIN event_partici ep ON e.event_no = ep.event_no "
				+ "WHERE ep.event_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();

		EventboardDto edto = rs.next() ? new EventboardDto(rs) : null;

		con.close();

		return edto;
	}

	// 단일조회
	public event_participateDto get(int event_partici_no) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM event_partici WHERE event_partici_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_partici_no);
		ResultSet rs = ps.executeQuery();

		event_participateDto epdto = rs.next() ? new event_participateDto(rs) : null;
		con.close();

		return epdto;
	}
	
	//중복방지
	public event_participateDto saMe(event_participateDto epdto) throws Exception{
		Connection con = getConnection();
		
		String sql = "select * from event_partici where event_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, epdto.getMember_no());
		ResultSet rs= ps.executeQuery();
		event_participateDto samE;
		if(rs.next()) {
			samE = new event_participateDto();
			samE.setEvent_partici_no(rs.getInt("event_partici_no"));
			samE.setMember_no(rs.getInt("member_no"));
			samE.setEvent_no(rs.getInt("event_no"));
			samE.setEvent_partici_date(rs.getString("event_partici_date"));
		} else {
			samE= null;
		}
		con.close();
		return samE;
	}
	
	// 회원번호 이벤트 테이블을 조회
	public Integer getEventCheck(int member_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT EVENT_PARTICI_NO FROM EVENT_PARTICI WHERE MEMBER_NO = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, member_no);
		
		ResultSet rs = ps.executeQuery();
		
		Integer result;
		
		if(rs.next()) {
			result = rs.getInt(1);
		} else {
			result = null;
		}
		
		con.close();
		
		return result;
	}

}
