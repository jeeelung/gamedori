package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class EventboardFileDto {

	private int event_no;
	private int file_no;
	
	
	
	public EventboardFileDto(ResultSet rs) throws SQLException {
		this.setEvent_no(rs.getInt("event_no"));
		this.setFile_no(rs.getInt("file_no"));
	}
	
	public EventboardFileDto() {
		super();
		
	}
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	
	
}