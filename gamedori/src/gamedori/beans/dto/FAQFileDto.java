package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

//faq_file_no number primary key,
//faq_file_name varchar2(256) not null,
//faq_file_size number not null check(faq_file_size>0),
//faq_file_type char(10) not null,
//faq_no references faq(faq_no) on delete cascade
public class FAQFileDto {
	private int faq_file_no;
	private String faq_file_name;
	private long faq_file_size;
	public int getFaq_file_no() {
		return faq_file_no;
	}
	public void setFaq_file_no(int faq_file_no) {
		this.faq_file_no = faq_file_no;
	}
	public String getFaq_file_name() {
		return faq_file_name;
	}
	public void setFaq_file_name(String faq_file_name) {
		this.faq_file_name = faq_file_name;
	}
	public long getFaq_file_size() {
		return faq_file_size;
	}
	public void setFaq_file_size(long faq_file_size) {
		this.faq_file_size = faq_file_size;
	}
	public String getFaq_file_type() {
		return faq_file_type;
	}
	public void setFaq_file_type(String faq_file_type) {
		this.faq_file_type = faq_file_type;
	}
	public int getFaq_no() {
		return faq_no;
	}
	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}
	private String faq_file_type;
	private int faq_no;
	public FAQFileDto() {
		super();
	}
	public FAQFileDto(ResultSet rs) throws SQLException{
		this.setFaq_file_no(rs.getInt("faq_file_no"));
		this.setFaq_file_name(rs.getString("faq_file_name"));
		this.setFaq_file_type(rs.getString("faq_file_type"));
		this.setFaq_file_size(rs.getLong("faq_file_size"));
		this.setFaq_no(rs.getInt("faq_no"));
	}
}
