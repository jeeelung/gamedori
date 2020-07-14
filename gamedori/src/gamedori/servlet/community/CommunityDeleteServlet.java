package gamedori.servlet.community;

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

import gamedori.beans.dao.CommunityDao;
import gamedori.beans.dao.CommunityFileDao;
import gamedori.beans.dao.FilesDao;
import gamedori.beans.dto.CommunityDto;
import gamedori.beans.dto.CommunityFileDto;
import gamedori.beans.dto.FilesDto;

@WebServlet(urlPatterns = "/community/delete.do")
public class CommunityDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 해야할 일
			// 1) community 에서 게시글 정보 삭제
			// 2) community_File 에서 commu_no에 해당되는 file_no 가져오기
			// 3) Files 에서 file_no 에 일치하는 데이터 삭제
			// 4) 실제 파일 삭제
			// 5) community_File 에서 commu_no에 해당되는 정보 삭제
			
			// 1
			CommunityFileDao cfdao = new CommunityFileDao();
			int commu_no = Integer.parseInt(req.getParameter("commu_no"));
			List<Integer> list = cfdao.getfileNo(commu_no);
			System.out.println(list.size());
			
			// 2
			CommunityDao cdao = new CommunityDao();
			cdao.delete(commu_no);
			
			// 3, 4
			FilesDao fdao = new FilesDao();
			int file_no;
			for(int i=0; i<list.size(); i++) {
				
				file_no = list.get(i);
				fdao.delete(file_no); // 3		
				
				File target = new File("D:/upload/community", String.valueOf(file_no));
				target.delete(); // 4
			}
			
			// 4
			cfdao.delete(commu_no);
			resp.sendRedirect("list.jsp");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
