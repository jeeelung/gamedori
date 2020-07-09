package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class EventboardDto {
	private int event_no, member_no;
	private String event_title, event_content, event_date, event_read;
	public EventboardDto() {
		super();
	
	}
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getEvent_content() {
		return event_content;
	}
	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	public String getEvent_date() {
		return event_date;
	}
	public void setEvent_date(String event_date) {
		this.event_date = event_date;
	}
	public String getEvent_read() {
		return event_read;
	}
	public void setEvent_read(String event_read) {
		this.event_read = event_read;
	}
	
	public EventboardDto(ResultSet rs) throws SQLException {
		this.setEvent_no(rs.getInt("event_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setEvent_title(rs.getString("event_title"));
		this.setEvent_content(rs.getString("event_content"));
		this.setEvent_date(rs.getString("event_date"));
		this.setEvent_read(rs.getString("event_read"));
	
	
		}
	
		
	}




