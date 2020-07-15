package gamedori.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.PointDao;
import gamedori.beans.dto.PointDto;
@WebServlet(urlPatterns="/member/point.do/")
public class AdminPointTypeServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");// 사용자의 요청을 UTF-8 형태로 복원하라!
			
			PointDao pdao =new PointDao();
			PointDto pdto = new PointDto();
			
			pdto.setPoint_type(req.getParameter("point_type"));
			pdto.setPoint_score(Integer.parseInt(req.getParameter("point_score")));
			
			
			pdao.pointInsert(pdto);
			
			resp.sendRedirect("MemberPointList.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
