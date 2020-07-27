package gamedori.servlet.notice;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FilesDao;
import gamedori.beans.dao.NoticeDao;
import gamedori.beans.dao.NoticeFileDao;

@WebServlet(urlPatterns = "/notice/delete.do")
public class NoticeDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			NoticeFileDao nfdao = new NoticeFileDao();
			int notice_no = Integer.parseInt(req.getParameter("notice_no"));
			List<Integer> list = nfdao.getfileNo(notice_no);
			System.out.println(list.size());
			
			NoticeDao ndao = new NoticeDao();
			ndao.delete(notice_no);
			

			FilesDao fdao = new FilesDao();
			int file_no;
			for (int i = 0; i < list.size(); i++) {

				file_no = list.get(i);
				fdao.delete(file_no);

				File target = new File("D:/upload/kh33/notice", String.valueOf(file_no));
				target.delete();
			}

			nfdao.delete(notice_no);
			resp.sendRedirect("list.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
