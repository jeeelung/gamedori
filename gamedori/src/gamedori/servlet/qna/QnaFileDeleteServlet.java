package gamedori.servlet.qna;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.activation.FileDataSource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.QnaDao;
import gamedori.beans.dao.QnaFileDao;
import gamedori.beans.dao.FilesDao;

@WebServlet(urlPatterns = "/qna/fileDelete.do")
public class QnaFileDeleteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int qna_no = Integer.parseInt(req.getParameter("qna_no"));
			int file_no = Integer.parseInt(req.getParameter("file_no"));
			FilesDao qdao = new FilesDao();
			qdao.delete(file_no);
			
			// 2	
			File target = new File("D:/upload/qna", String.valueOf(file_no));
			target.delete();
			
			// 3
			QnaFileDao qfdao = new QnaFileDao();
			qfdao.deleteFile(file_no);
			
			resp.sendRedirect("qna_edit.jsp?qna_no="+qna_no);

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}