package gamedori.servlet.community;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.activation.FileDataSource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.CommunityDao;
import gamedori.beans.dao.CommunityFileDao;
import gamedori.beans.dao.FilesDao;

@WebServlet(urlPatterns = "/community/fileDelete.do")
public class CommunityFileDeleteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 1) Files에서 file_no 에 일치하는 데이터 삭제
			// 2) 실제 파일 삭제
			// 3) community_File 에서 file_no와 일치하는 정보 삭제

			// 1
			int commu_no = Integer.parseInt(req.getParameter("commu_no"));
			int file_no = Integer.parseInt(req.getParameter("file_no"));
			FilesDao fdao = new FilesDao();
			fdao.delete(file_no);
			
			// 2	
			File target = new File("D:/upload/kh33/community", String.valueOf(file_no));
			target.delete();
			
			// 3
			CommunityFileDao cfdao = new CommunityFileDao();
			cfdao.deleteFile(file_no);
			
			resp.sendRedirect("edit.jsp?commu_no="+commu_no);

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
