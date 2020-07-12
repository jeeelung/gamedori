package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReplyDto {

	private int reply_no;
	private int member_no;
	private String reply_content;
	private String reply_date;
	private int reply_super_no;
	private int reply_group_no;
	private int reply_depth;

	
	


	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public int getReply_super_no() {
		return reply_super_no;
	}
	public void setReply_super_no(int reply_super_no) {
		this.reply_super_no = reply_super_no;
	}
	public int getReply_group_no() {
		return reply_group_no;
	}
	public void setReply_group_no(int reply_group_no) {
		this.reply_group_no = reply_group_no;
	}
	public int getReply_depth() {
		return reply_depth;
	}
	public void setReply_depth(int reply_depth) {
		this.reply_depth = reply_depth;
	}
	public ReplyDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReplyDto(ResultSet rs) throws SQLException {
		this.setReply_no(rs.getInt("reply_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setReply_content(rs.getString("reply_content"));
		this.setReply_date(rs.getString("reply_date"));
		this.setReply_super_no(rs.getInt("reply_super_no"));
		this.setReply_group_no(rs.getInt("reply_group_no"));
		this.setReply_depth(rs.getInt("reply_depth"));
		
	}
	
	
}
