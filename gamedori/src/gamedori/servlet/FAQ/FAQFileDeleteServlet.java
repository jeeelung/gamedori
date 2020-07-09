package gamedori.servlet.FAQ;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FAQFileDao;
import gamedori.beans.dao.FilesDao;

@WebServlet(urlPatterns = "/faq/fileDelete.do")
public class FAQFileDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try{
			int faq_no = Integer.parseInt(req.getParameter("faq_no"));
			int file_no = Integer.parseInt(req.getParameter("file_no"));
			FilesDao filesdao = new FilesDao();
			filesdao.delete(file_no);
			
			// 2	
			File target = new File("D:/upload/community", String.valueOf(file_no));
			target.delete();
			
			// 3
			FAQFileDao cfdao = new FAQFileDao();
			cfdao.deleteFile(file_no);
			
			resp.sendRedirect("edit.jsp?faq_no="+faq_no);
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
