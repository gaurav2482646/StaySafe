
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mobileEditContactServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            int id = Integer.parseInt(request.getParameter("id"));
            String contactName = request.getParameter("contactname");
            String contactNo = request.getParameter("contactno");
            String relation = request.getParameter("relation");

            //JDBC CODE
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from user_contacts where cid = " + id);
            if (rs.next())
            {
                rs.updateString("contact_name", contactName);
                rs.updateString("contact_no", contactNo);
                rs.updateString("relation", relation);
                rs.updateRow();

                out.println("Contact Updated successfully");
            } else
            {
                out.println("No_Contact_to_edit");
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
