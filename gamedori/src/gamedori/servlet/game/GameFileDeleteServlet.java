package gamedori.servlet.game;

import java.io.File;
import java.io.IOException;

import javax.activation.FileDataSource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FilesDao;
import gamedori.beans.dao.GameDao;
import gamedori.beans.dao.GameFileDao;
import gamedori.beans.dao.GameImgDao;
import gamedori.beans.dto.GameDto;
@WebServlet(urlPatterns = "/game/delete.do")
public class GameFileDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int game_no = Integer.parseInt(req.getParameter("game_no"));
			GameDao gdao = new GameDao();
			
			GameImgDao gidao = new GameImgDao();
			int game_img_no = gidao.getGameImgNo(game_no);
			
			GameFileDao gfdao = new GameFileDao();
			int file_no = gfdao.getFileNo(game_no);
			
			FilesDao fdao = new FilesDao();
			
			// 4
			File target = new File("D:/upload/game/file", String.valueOf(file_no));
			target.delete();
			File targetImg = new File("D:/upload/game/img", String.valueOf(game_img_no));
			targetImg.delete();
			
			// 5
			fdao.delete(file_no); // 3
			gfdao.delete(game_no);
			gidao.delete(game_no);
			gdao.delete(game_no);
			
			resp.sendRedirect("latestlist.jsp");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
