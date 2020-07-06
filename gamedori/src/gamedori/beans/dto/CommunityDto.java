package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CommunityDto {

	private int commu_no;
	private int member_no;
	private String commu_head;
	private String commu_title;
	private String commu_content;
	private String commu_date;
	private int commu_read;
	private int commu_replycount;
	private int commu_super_no;
	private int commu_group_no;
	private int commu_depth;
	
	public CommunityDto() {
		super();
	}
	
	public CommunityDto(ResultSet rs) throws SQLException {
		setCommu_no(rs.getInt("commu_no"));
		setMember_no(rs.getInt("member_no"));
		setCommu_head(rs.getString("commu_head"));
		setCommu_title(rs.getString("commu_title"));
		setCommu_content(rs.getString("commu_content"));
		setCommu_date(rs.getString("commu_date"));
		setCommu_read(rs.getInt("commu_read"));
		setCommu_replycount(rs.getInt("commu_replycount"));
		setCommu_super_no(rs.getInt("commu_super_no"));
		setCommu_group_no(rs.getInt("commu_group_no"));
		setCommu_depth(rs.getInt("commu_depth"));
	}

	public int getCommu_no() {
		return commu_no;
	}

	public void setCommu_no(int commu_no) {
		this.commu_no = commu_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getCommu_head() {
		return commu_head;
	}

	public void setCommu_head(String commu_head) {
		this.commu_head = commu_head;
	}

	public String getCommu_title() {
		return commu_title;
	}

	public void setCommu_title(String commu_title) {
		this.commu_title = commu_title;
	}

	public String getCommu_content() {
		return commu_content;
	}

	public void setCommu_content(String commu_content) {
		this.commu_content = commu_content;
	}

	public String getCommu_date() {
		return commu_date;
	}
	
	// 날짜 자동 변환 메소드
	public String getCommu_time() {
		return commu_date.substring(0, 10);
	}
	
	public String getCommu_day() {
		return commu_date.substring(11, 16);
	}
	
	public String getCommu_auto() {
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		return today;
	}

	public void setCommu_date(String commu_date) {
		this.commu_date = commu_date;
	}

	public int getCommu_read() {
		return commu_read;
	}

	public void setCommu_read(int commu_read) {
		this.commu_read = commu_read;
	}

	public int getCommu_replycount() {
		return commu_replycount;
	}

	public void setCommu_replycount(int commu_replycount) {
		this.commu_replycount = commu_replycount;
	}

	public int getCommu_super_no() {
		return commu_super_no;
	}

	public void setCommu_super_no(int commu_super_no) {
		this.commu_super_no = commu_super_no;
	}

	public int getCommu_group_no() {
		return commu_group_no;
	}

	public void setCommu_group_no(int commu_group_no) {
		this.commu_group_no = commu_group_no;
	}

	public int getCommu_depth() {
		return commu_depth;
	}

	public void setCommu_depth(int commu_depth) {
		this.commu_depth = commu_depth;
	}
	
	
}
