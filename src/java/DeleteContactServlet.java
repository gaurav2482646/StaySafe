import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteContactServlet extends HttpServlet
{
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try
        {
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            int cid = Integer.parseInt(request.getParameter("cid"));
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from user_contacts where cid = "+cid);
            
            if(rs.next())
            {
                rs.deleteRow();
                out.println("Record deleted successfully");
            }
            else
            {
                out.println("Record not found");
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
