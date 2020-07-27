package gamedori.servlet.game;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import gamedori.beans.dao.FilesDao;
import gamedori.beans.dao.GameImgDao;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.GameImgDto;
@WebServlet(urlPatterns = "/game/imgDownload.do")
public class GameImgDownloadServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int game_img_no = Integer.parseInt(req.getParameter("game_img_no"));
			
			GameImgDao gidao = new GameImgDao();
			GameImgDto gidto = gidao.get(game_img_no);
			
			if(gidto == null) {
				resp.sendError(404);
				return;
			}
			
			resp.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(gidto.getGame_img_name(), "UTF-8")+"\"");
			resp.setHeader("Content-Length", String.valueOf(gidto.getGame_img_size()));
			
			File target = new File("D:/upload/kh33/game/img", String.valueOf(gidto.getGame_img_no()));
			byte[] data = FileUtils.readFileToByteArray(target);
			resp.getOutputStream().write(data); // 사용자에게 전송
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	}
}
