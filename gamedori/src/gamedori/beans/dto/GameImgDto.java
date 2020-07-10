package gamedori.beans.dto;

public class GameImgDto {
	
	private int game_no;
	private int game_img_no;
	private String game_img_name;
	private String game_img_type;
	private long game_img_size;
	
	public GameImgDto() {
		super();
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
