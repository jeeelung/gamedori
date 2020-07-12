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
@WebServlet(urlPatterns = "/community/write.do")
public class CommunityWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		
		try {
			
			String charset = "UTF-8"; // 해석할 인코딩 방식
			int limit = 10 * 1024 * 1024; // 최대 허용 용량
			File baseDir = new File("D:/upload/community");
			baseDir.mkdirs();
			
			DiskFileItemFactory factory = new DiskFileItemFactory(limit, baseDir);
			factory.setDefaultCharset(charset);
			
			ServletFileUpload utility = new ServletFileUpload(factory);
			
			Map<String, List<FileItem>> map = utility.parseParameterMap(req);
			
			CommunityDto cdto = new CommunityDto();
			cdto.setMember_no(Integer.parseInt(map.get("member_no").get(0).getString()));
			cdto.setCommu_head(map.get("commu_head").get(0).getString());
			cdto.setCommu_title(map.get("commu_title").get(0).getString());
			cdto.setCommu_content(map.get("commu_content").get(0).getString());
			
			if(map.containsKey("commu_super_no")) {
				cdto.setCommu_super_no(Integer.parseInt(map.get("commu_super_no").get(0).getString()));
			}
			
			CommunityDao cdao = new CommunityDao();
			int commu_no = cdao.getSequence();
			cdto.setCommu_no(commu_no);
			
			cdao.write(cdto);
			
			List<FileItem> fileList = map.get("commu_file");
			
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
					
					CommunityFileDto cfdto = new CommunityFileDto();
					cfdto.setCommu_no(commu_no);
					cfdto.setFile_no(file_no);
					
					CommunityFileDao cfdao = new CommunityFileDao();
					cfdao.save(cfdto);
					
					File target = new File(baseDir, String.valueOf(file_no));
					item.write(target);
				}
			}
			
			resp.sendRedirect("content.jsp?commu_no="+commu_no);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
