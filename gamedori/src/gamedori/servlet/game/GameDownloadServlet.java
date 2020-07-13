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
import gamedori.beans.dao.GameFileDao;
import gamedori.beans.dto.FilesDto;
@WebServlet(urlPatterns = "/game/download.do")
public class GameDownloadServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int game_no = Integer.parseInt(req.getParameter("game_no"));
			
			GameFileDao gfdao = new GameFileDao();
			int file_no = gfdao.getFileNo(game_no);
			
			FilesDao fdao = new FilesDao();
			FilesDto fdto = fdao.get(file_no);
			
			if(fdto == null) {
				resp.sendError(404);
				return;
			}
			
			resp.setHeader("Content-Type", "application/x-shockwave-flash; charset=UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(fdto.getFile_name(), "UTF-8")+"\"");
			resp.setHeader("Content-Length", String.valueOf(fdto.getFile_size()));
			
			File target = new File("D:/upload/game", String.valueOf(fdto.getFile_no()));
			byte[] data = FileUtils.readFileToByteArray(target);
			resp.getOutputStream().write(data); // 사용자에게 전송
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
