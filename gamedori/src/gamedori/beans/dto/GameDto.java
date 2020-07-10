package gamedori.beans.dto;

import java.sql.ResultSet;

public class GameDto {

	private int game_no;
	private int member_no;
	private String game_name;
	private String game_date;
	private String game_intro;
	private int game_play;
	private int game_read;
	
	public GameDto() {
		super();
	}
	
	public GameDto(ResultSet rs) throws Exception {
		this.setGame_no(rs.getInt("game_no"));
		this.setMember_no(rs.getInt("member_no"));
		this.setGame_name(rs.getString("game_name"));
		this.setGame_date(rs.getString("game_date"));
		this.setGame_intro(rs.getString("game_intro"));
		this.setGame_play(rs.getInt("game_play"));
		this.setGame_read(rs.getInt("game_read"));
	}

	public int getGame_no() {
		return game_no;
	}

	public void setGame_no(int game_no) {
		this.game_no = game_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getGame_name() {
		return game_name;
	}

	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}

	public String getGame_date() {
		return game_date;
	}

	public void setGame_date(String game_date) {
		this.game_date = game_date;
	}

	public String getGame_intro() {
		return game_intro;
	}

	public void setGame_intro(String game_intro) {
		this.game_intro = game_intro;
	}

	public int getGame_play() {
		return game_play;
	}

	public void setGame_play(int game_play) {
		this.game_play = game_play;
	}

	public int getGame_read() {
		return game_read;
	}

	public void setGame_read(int game_read) {
		this.game_read = game_read;
	}
	
	
}
