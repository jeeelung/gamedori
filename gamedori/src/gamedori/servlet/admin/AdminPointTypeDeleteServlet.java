package gamedori.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.PointDao;
@WebServlet("/member/pointdelete.do")
public class AdminPointTypeDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				req.setCharacterEncoding("UTF-8");// 사용자의 요청을 UTF-8 형태로 복원하라!
				
				
				
				int point_no=Integer.parseInt(req.getParameter("point_no"));
				String point_type=req.getParameter("point_type");
				
				PointDao pdao=new PointDao();
				
				pdao.delete(point_no,point_type);

				
				resp.sendRedirect("MemberPointList.jsp");
			}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
	
}
