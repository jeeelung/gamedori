package gamedori.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.PointDao;
import gamedori.beans.dto.PointDto;
@WebServlet(urlPatterns="/member/pointedit.do")
public class AdminPointTypeEditServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			PointDto pdto = new PointDto();
			PointDao pdao = new PointDao();
			pdto.setPoint_type(req.getParameter("point_type"));
			pdto.setPoint_score(Integer.parseInt(req.getParameter("point_score")));
			pdto.setPoint_no(Integer.parseInt(req.getParameter("point_no")));
			
			pdao.edit(pdto);
			
			resp.sendRedirect("MemberPointList.jsp");
		}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
		}
	}

}

