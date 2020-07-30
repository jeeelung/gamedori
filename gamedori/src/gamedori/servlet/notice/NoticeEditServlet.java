package gamedori.servlet.notice;

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
import gamedori.beans.dao.NoticeDao;
import gamedori.beans.dao.NoticeFileDao;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.NoticeDto;
import gamedori.beans.dto.NoticeFileDto;

@WebServlet(urlPatterns = "/notice/edit.do")
public class NoticeEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {

			String charset = "UTF-8"; // 해석할 인코딩 방식
			int limit = 10 * 1024 * 1024; // 최대 허용 용량
			File baseDir = new File("D:/upload/kh33/notice");

			DiskFileItemFactory factory = new DiskFileItemFactory(limit, baseDir);
			factory.setDefaultCharset(charset);

			ServletFileUpload utility = new ServletFileUpload(factory);

			Map<String, List<FileItem>> map = utility.parseParameterMap(req);

			NoticeDto ndto = new NoticeDto();			
			ndto.setNotice_title(map.get("notice_title").get(0).getString());
			ndto.setNotice_content(map.get("notice_content").get(0).getString());

			NoticeDao ndao = new NoticeDao();
			int notice_no = Integer.parseInt(map.get("notice_no").get(0).getString());
			ndto.setNotice_no(notice_no);

			ndao.edit(ndto);

			List<FileItem> fileList = map.get("notice_file");

			for (FileItem item : fileList) {

				if (item.getSize() > 0) { // 파일이 있는 경우

					FilesDao fdao = new FilesDao();
					FilesDto fdto = new FilesDto();

					int file_no = fdao.getSequence();
					fdto.setFile_no(file_no);
					fdto.setFile_name(item.getName());
					fdto.setFile_size(item.getSize());
					fdto.setFile_type(item.getContentType());
					fdao.save(fdto);

					NoticeFileDto nfdto = new NoticeFileDto();
					nfdto.setNotice_no(notice_no);
					nfdto.setFile_no(file_no);

					NoticeFileDao nfdao = new NoticeFileDao();
					nfdao.save(nfdto);

					File target = new File(baseDir, String.valueOf(file_no));
					item.write(target);
				}
			}

			resp.sendRedirect("content.jsp?notice_no=" + notice_no);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
