package gamedori.servlet.game;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/f")
public class TestServlet extends HttpServlet{
   @Override
   protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      File file = new File("D:/upload/game/file/"+req.getParameter("no"));
      byte[] arr = new byte[(int)file.length()];
      FileInputStream in = new FileInputStream(file);
      in.read(arr);
      in.close();
      
      resp.setCharacterEncoding("UTF-8");
      resp.setContentType("application/x-shockwave-flash");
      
      resp.getOutputStream().write(arr);
   }
}