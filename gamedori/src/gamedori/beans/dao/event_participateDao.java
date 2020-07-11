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
		
		//회원 포인트
		public MemberDto getPoint(int member_no) throws Exception {
	 		Connection con = getConnection();
	 		String sql = "SELECT m.* " + "FROM member m INNER JOIN event_participate e " + "ON m.member_no = e.member_no "
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
	         String sql = "SELECT * FROM event_paricipate WHERE member_no = ? AND event_no=?";
	         PreparedStatement ps = con.prepareStatement(sql);
	         ps.setInt(1, member_no);	 
	         ps.setInt(2, event_no);
	         
	         ResultSet rs = ps.executeQuery();
	         
	         List<event_participateDto> list = new ArrayList<event_participateDto>();
	         
	         while(rs.next()) {
	        	 event_participateDto epdto = new event_participateDto(rs);
	            list.add(epdto);
	         }
	         
	         con.close();
	         return list;
	      }

	      // 응모하게 될 시 insert문
	       public void writeEvent(event_participateDto epdto) throws Exception {

	         Connection con = getConnection();
	         String sql = "INSERT INTO event_paricipate (member_no, event_no, event_parici_date) VALUES (?, ?, SYSDATE)";
	         PreparedStatement ps = con.prepareStatement(sql);
	         ps.setInt(1, epdto.getMember_no());
	         ps.setInt(2, epdto.getEvent_no());

	         ps.execute();
	         con.close();
	      }

	      // 응모내역 DELETE문
	       public void deleteEvent(event_participateDto epdto) throws Exception {

	         Connection con = getConnection();
	         String sql = "DELETE FROM event_paricipate WHERE member_no =? and event_no = ?";
	         PreparedStatement ps = con.prepareStatement(sql);
	         ps.setInt(1, epdto.getMember_no());
	         ps.setInt(2, epdto.getEvent_no());

	         ps.execute();
	         con.close();
	      }}