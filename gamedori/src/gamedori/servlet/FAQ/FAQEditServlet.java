package gamedori.servlet.FAQ;

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

import gamedori.beans.dao.FAQDao;
import gamedori.beans.dao.FAQFileDao;
import gamedori.beans.dao.FilesDao;
import gamedori.beans.dto.FAQDto;
import gamedori.beans.dto.FAQFileDto;
import gamedori.beans.dto.FilesDto;
import gamedori.beans.dto.MemberDto;

@WebServlet(urlPatterns = "/faq/edit.do")
public class FAQEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : faq_head, faq_title, faq_content, faq_no -> faqDto
			// 1.
			String charset = "UTF-8";
			int limit = 10 * 1024 * 1024;
			File baseDir = new File("D:/upload/faq");
			baseDir.mkdirs();

			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setDefaultCharset(charset);
			factory.setSizeThreshold(limit);
			factory.setRepository(baseDir);

			ServletFileUpload utility = new ServletFileUpload(factory);

			Map<String, List<FileItem>> map = utility.parseParameterMap(req);
			FAQDto fdto = new FAQDto();
			fdto.setFaq_head(map.get("faq_head").get(0).getString());
			fdto.setFaq_title(map.get("faq_title").get(0).getString());
			fdto.setFaq_content(map.get("faq_content").get(0).getString());
			
			MemberDto user = (MemberDto) req.getSession().getAttribute("userinfo");
			fdto.setMember_no(user.getMember_no());

			FAQDao fdao = new FAQDao();
			int faq_no = Integer.parseInt(map.get("faq_no").get(0).getString());
			fdto.setFaq_no(faq_no);
			fdao.edit(fdto);
			List<FileItem> fileList = map.get("faq_file");
			
			for (FileItem item : fileList) {
				if (item.getSize() > 0) {
					FilesDao filesdao = new FilesDao();
					FilesDto filesdto = new FilesDto();
					int file_no = Integer.parseInt(map.get("file_no").get(0).getString());
					filesdto.setFile_no(file_no);
					filesdto.setFile_name(item.getName());
					filesdto.setFile_size(item.getSize());
					filesdto.setFile_type(item.getContentType());
					filesdao.save(filesdto);
					FAQFileDto ffdto = new FAQFileDto();
					ffdto.setFaq_no(faq_no);
					ffdto.setFile_no(file_no);

					FAQFileDao ffdao = new FAQFileDao();
					ffdao.save(ffdto);

					File target = new File(baseDir, String.valueOf(file_no));
					item.write(target);
				}
			}
			

//			출력  
			resp.sendRedirect("content.jsp?faq_no=" + faq_no);
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}