
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mobileFetchContactsServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            String email = request.getParameter("email");
            //JDBC CODE
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from user_contacts where user_email = '" + email + "'");
            if (rs.next())
            {
               rs.beforeFirst();
               while(rs.next())
               {
                   String id = rs.getInt("cid")+"";
                   String contactName = rs.getString("contact_name");
                   String contactNo = rs.getString("contact_no");
                   String relation = rs.getString("relation");
                   out.println(id+"#"+contactName+"#"+contactNo+"#"+relation);
               }
               out.println("end_of_contacts");
            }
            else
            {
                out.println("Contact List is empty");
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
