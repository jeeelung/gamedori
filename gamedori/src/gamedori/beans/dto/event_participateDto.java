package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class event_participateDto {

	private int event_partici_no;
	private int member_no;
	private int event_no;
	private String event_partici_date;
	public event_participateDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getEvent_partici_no() {
		return event_partici_no;
	}
	public void setEvent_partici_no(int event_partici_no) {
		this.event_partici_no = event_partici_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public String getEvent_partici_date() {
		return event_partici_date;
	}
	public void setEvent_partici_date(String event_partici_date) {
		this.event_partici_date = event_partici_date;
	}
	public event_participateDto(ResultSet rs) throws SQLException {
		this.setEvent_partici_no(rs.getInt("event_partici_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setEvent_no(rs.getInt("event_no"));
		this.setEvent_partici_date(rs.getString("event_partici_date"));
		
	}

	
	
	
}
