package gamedori.beans.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class GameListDto {
	private int genre_no;
	private String genre_type;
	private int member_no;

	private String member_nick;
	private String game_name;
	private String game_date;
	private int game_no;
	private int game_img_no;
	private String game_img_name;
	private String game_img_type;
	private long game_img_size;
	private int row_num;
	
	public int getRow_num() {
		return row_num;
	}

	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}

	public GameListDto() {
		super();
	}
	
	public GameListDto(ResultSet rs) throws SQLException {
		this.setGenre_no(rs.getInt("genre_no"));
		this.setGenre_type(rs.getString("genre_type"));
		this.setMember_no(rs.getInt("member_no"));
		this.setMember_nick(rs.getString("member_nick"));
		this.setGame_name(rs.getString("game_name"));
		this.setGame_date(rs.getString("game_date"));
		this.setGame_no(rs.getInt("game_no"));
		this.setGame_img_no(rs.getInt("game_img_no"));
		this.setGame_img_name(rs.getString("game_img_name"));
		this.setGame_img_type(rs.getString("game_img_type"));
		this.setGame_img_size(rs.getLong("game_img_size"));
	}

	
	public int getGenre_no() {
		return genre_no;
	}

	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}

	public String getGenre_type() {
		return genre_type;
	}

	public void setGenre_type(String genre_type) {
		this.genre_type = genre_type;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	public String getGame_date() {
		return game_date;
	}

	public String getGame_time() {
		return game_date.substring(11, 16);
	}
	
	public String getGame_day() {
		return game_date.substring(0, 10);
	}
	
	public String getGame_auto() {
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if(getGame_day().equals(today)) {
			return getGame_time();
		} else {
			return getGame_day();
		}
	}
	
	public void setGame_date(String game_date) {
		this.game_date = game_date;
	}

	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}

	public String getGame_name() {
		return game_name;
	}

	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}

	public int getGame_no() {
		return game_no;
	}

	public void setGame_no(int game_no) {
		this.game_no = game_no;
	}

	public int getGame_img_no() {
		return game_img_no;
	}

	public void setGame_img_no(int game_img_no) {
		this.game_img_no = game_img_no;
	}

	public String getGame_img_name() {
		return game_img_name;
	}

	public void setGame_img_name(String game_img_name) {
		this.game_img_name = game_img_name;
	}

	public String getGame_img_type() {
		return game_img_type;
	}

	public void setGame_img_type(String game_img_type) {
		this.game_img_type = game_img_type;
	}

	public long getGame_img_size() {
		return game_img_size;
	}

	public void setGame_img_size(long game_img_size) {
		this.game_img_size = game_img_size;
	}
	
}
