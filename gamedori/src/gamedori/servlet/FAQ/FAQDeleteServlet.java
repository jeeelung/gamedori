package gamedori.servlet.FAQ;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FAQDao;
import gamedori.beans.dao.FAQFileDao;
import gamedori.beans.dao.FilesDao;

@WebServlet(urlPatterns = "/faq/delete.do")
public class FAQDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			FAQFileDao ffdao = new FAQFileDao();
//			입력 : faq_no
			int faq_no = Integer.parseInt(req.getParameter("faq_no"));
			List<Integer> list = ffdao.getFileNo(faq_no);
			System.out.println(list.size());
//			처리 : 삭제
			FAQDao fdao = new FAQDao();
			fdao.delete(faq_no);//삭제
			FilesDao filesdao =new FilesDao();
			int file_no;
			for(int i=0; i<list.size(); i++) {
				file_no = list.get(i);
				filesdao.delete(file_no);
				File target = new File("D:/upload/kh33/faq", String.valueOf(file_no));
				target.delete();
			}
//			출력 : list.jsp로 redirect
			resp.sendRedirect("list.jsp");
		}
		catch(Exception e) { 
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}