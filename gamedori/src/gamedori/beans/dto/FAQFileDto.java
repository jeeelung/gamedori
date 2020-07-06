package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

//faq_file 테이블을 옮겨담기 위한 DTO 클래스
public class FAQFileDto {
	private int faq_file_no;
	private String faq_file_name;
	private String faq_file_type;
	private long faq_file_size;
	private int faq_origin;
	
	public FAQFileDto(ResultSet rs) throws SQLException {
		this.setfaq_file_no(rs.getInt("faq_file_no"));
		this.setfaq_file_name(rs.getString("faq_file_name"));
		this.setfaq_file_type(rs.getString("faq_file_type"));
		this.setfaq_file_size(rs.getLong("faq_file_size"));
		this.setfaq_origin(rs.getInt("faq_origin"));
	}
	
	public FAQFileDto() {
		super();
	}
	
	public int getfaq_file_no() {
		return faq_file_no;
	}
	public void setfaq_file_no(int faq_file_no) {
		this.faq_file_no = faq_file_no;
	}
	public String getfaq_file_name() {
		return faq_file_name;
	}
	public void setfaq_file_name(String faq_file_name) {
		this.faq_file_name = faq_file_name;
	}
	public String getfaq_file_type() {
		return faq_file_type;
	}
	public void setfaq_file_type(String faq_file_type) {
		this.faq_file_type = faq_file_type;
	}
	public long getfaq_file_size() {
		return faq_file_size;
	}
	public void setfaq_file_size(long faq_file_size) {
		this.faq_file_size = faq_file_size;
	}
	public int getfaq_origin() {
		return faq_origin;
	}
	public void setfaq_origin(int faq_origin) {
		this.faq_origin = faq_origin;
	}
}
