package gamedori.servlet.game;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import gamedori.beans.dao.FilesDao;
import gamedori.beans.dao.GameDao;
import gamedori.beans.dao.GameFileDao;
import gamedori.beans.dao.GameGenreDao;
import gamedori.beans.dao.GameImgDao;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.GameDto;
import gamedori.beans.dto.GameFileDto;
import gamedori.beans.dto.GameGenreDto;
import gamedori.beans.dto.GameImgDto;

@WebServlet(urlPatterns = "/game/upload.do")
public class GameFileUploadServlet extends HttpServlet{
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		
		try {
			
			String charset = "UTF-8"; // 해석할 인코딩 방식
			int limit = 10 * 1024 * 1024; // 최대 허용 용량
			File fileBaseDir = new File("D:/upload/game");
			fileBaseDir.mkdirs();
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(limit);
			factory.setDefaultCharset(charset);
			factory.setRepository(fileBaseDir);
			
			ServletFileUpload utility = new ServletFileUpload();
			utility.setFileItemFactory(factory);			
			
			Map<String, List<FileItem>> map = utility.parseParameterMap(req);
			
			// 게임 테이블에 정보 전송
			GameDto gdto = new GameDto();
			gdto.setMember_no(Integer.parseInt(map.get("member_no").get(0).getString()));
			gdto.setGame_name(map.get("game_name").get(0).getString());
			gdto.setGame_intro(map.get("game_intro").get(0).getString());
			
			GameDao gdao = new GameDao();
			int game_no = gdao.getSequence();
			gdto.setGame_no(game_no);
			
			gdao.write(gdto);
			
			// 게임 장르 테이블에 정보 전송
			GameGenreDto ggdto = new GameGenreDto();
			ggdto.setGame_no(game_no);
			ggdto.setGenre_no(Integer.parseInt(map.get("game_genre").get(0).getString()));
			
			GameGenreDao ggdao = new GameGenreDao();
			int game_genre_no = ggdao.getSeq();
			ggdto.setGame_genre_no(game_genre_no);
			
			ggdao.write(ggdto);
			
			// 게임 파일 꺼내기
			List<FileItem> fileList = map.get("game_file");
			
			for(FileItem item : fileList) {
				
				if(item.getSize() > 0) { // 파일이 있는 경우
					
					FilesDao fdao = new FilesDao();
					FilesDto fdto = new FilesDto();
					
					int file_no = fdao.getSequence();
					fdto.setFile_no(file_no);
					fdto.setFile_name(item.getName());
					fdto.setFile_size(item.getSize());
					fdto.setFile_type(item.getContentType());
					fdao.save(fdto);
					
					GameFileDto gfdto = new GameFileDto();
					gfdto.setGame_no(game_no);
					gfdto.setFile_no(file_no);
					
					GameFileDao gfdao = new GameFileDao();
					gfdao.save(gfdto);
					
					File target = new File(fileBaseDir+"/file", String.valueOf(file_no));
					item.write(target);
				}
			}
			
			// 이미지 파일 경로 설정
			File imgBaseDir = new File("D:/upload/game/img");
			imgBaseDir.mkdirs();
			
			// 이미지 파일 꺼내기
			List<FileItem> imgList = map.get("game_img");
			
			for(FileItem item : imgList) {
				
				if(item.getSize() > 0) { // 파일이 있는 경우
					
					GameImgDto gidto = new GameImgDto();
					GameImgDao gidao = new GameImgDao();
					
					int game_img_no = gidao.getSequence();
					gidto.setGame_no(game_no);
					gidto.setGame_img_no(game_img_no);
					gidto.setGame_img_name(item.getName());
					gidto.setGame_img_size(item.getSize());
					gidto.setGame_img_type(item.getContentType());
					gidao.save(gidto);
					
					File target = new File(fileBaseDir+"/img", String.valueOf(game_img_no));
					item.write(target);
				}
			}
			resp.sendRedirect("content.jsp?game_no="+game_no);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
