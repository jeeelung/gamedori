package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class EventDto {

	private String event_title;
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
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
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public EventDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	private String member_id;
	private String event_content;
	private String event_date;
	private String event_read;
	private int event_no;
	

	private int super_no;
	private int group_no;
	private int depth;
	private int eventboard_replycount;
	
	
	public int getSuper_no() {
		return super_no;
	}
	public void setSuper_no(int super_no) {
		this.super_no = super_no;
	}
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getEventboard_replycount() {
		return eventboard_replycount;
	}
	public void setEventboard_replycount(int eventboard_replycount) {
		this.eventboard_replycount = eventboard_replycount;
	}
	public EventDto(ResultSet rs) throws SQLException {
		this.setEvent_no(rs.getInt("event_no"));
		this.setMember_id(rs.getString("member_id"));
		this.setEvent_title(rs.getString("event_title"));
		this.setEvent_content(rs.getString("event_content"));
		this.setEvent_date(rs.getString("event_date"));
		this.setEvent_read(rs.getString("event_read"));
	
}
	//메소드 2개를 추가
			//[1] getBoard_time() : 시간을 반환하는 메소드
			//[2] getBoard_day() : 날짜를 반환하는 메소드
			//[3] getBoard_autotime() : 자동으로 오늘날짜에는 시간을, 아닌 경우는 날짜를 반환
			public String getEventboard_time() {
				return event_date.substring(11, 16);
			}
			
			public String getEventboard_day() {
				return event_date.substring(0, 10);
			}
			
			public String getEventboard_autotime() {
//				Date d = new Date();
//				Format f = new SimpleDateFormat("yyyy-MM-dd");
//				String today = f.format(d);
				String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				if(getEventboard_day().equals(today)) {//오늘 작성한 글이라면
					return getEventboard_time();
				}
				else {//아니라면
					return getEventboard_day();
				}
			}
}
