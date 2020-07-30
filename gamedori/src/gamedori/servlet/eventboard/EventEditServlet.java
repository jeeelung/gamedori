package gamedori.servlet.eventboard;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import gamedori.beans.dao.EventFileDao;
import gamedori.beans.dao.EventboardDao;
import gamedori.beans.dao.FilesDao;
import gamedori.beans.dto.EventFileDto;
import gamedori.beans.dto.EventboardDto;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.MemberDto;



@WebServlet(urlPatterns = "/eventboard/eventedit.do")
public class EventEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			String charset = "UTF-8"; // 해석할 인코딩 방식
			int limit = 10 * 1024 * 1024; // 최대 허용 용량
			File baseDir = new File("D:/upload/kh33/eventupload/board");
			
			DiskFileItemFactory factory = new DiskFileItemFactory(limit, baseDir);
			factory.setDefaultCharset(charset);
			
			ServletFileUpload utility = new ServletFileUpload(factory);
			
			Map<String, List<FileItem>> map = utility.parseParameterMap(req);
			
			EventboardDto edto = new EventboardDto();
			
			edto.setEvent_title(map.get("event_title").get(0).getString());
			edto.setEvent_content(map.get("event_content").get(0).getString());
			
			EventboardDao edao = new EventboardDao();
			int event_no = Integer.parseInt(map.get("event_no").get(0).getString());
			edto.setEvent_no(event_no);
			
			edao.edit(edto);
			
			List<FileItem> fileList = map.get("event_file");
			
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
					
					EventFileDto efdto = new EventFileDto();
					efdto.setEvent_no(event_no);
					efdto.setFile_no(file_no);
					
					EventFileDao efdao = new EventFileDao();
					efdao.save(efdto);
					
					File target = new File(baseDir, String.valueOf(file_no));
					item.write(target);
				}
			}
			
			resp.sendRedirect("Eventcontent.jsp?event_no="+event_no);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}