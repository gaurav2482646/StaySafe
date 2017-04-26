
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mobileAddContactServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            String email = request.getParameter("email");
            String contactName = request.getParameter("contactname");
            String contactNo = request.getParameter("contactno");
            String relation = request.getParameter("relation");
            //JDBC CODE
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select count(*) from user_contacts where user_email = '" + email + "'");
            if (rs.next())
            {
                int count = rs.getInt(1);
                if (count == 5)
                {
                    out.println("Cannot add more Contacts");
                } 
                else
                {
                    Statement stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ResultSet rs1 = stmt1.executeQuery("select * from user_contacts where user_email ='" + email + "' and contact_name='" + contactName + "' and contact_no ='" + contactNo + "'");

                    if (rs1.next())
                    {
                        out.println("Contact already in the list");
                    } else
                    {
                        rs1.moveToInsertRow();
                        rs1.updateString("contact_name", contactName);
                        rs1.updateString("contact_no", contactNo);
                        rs1.updateString("relation", relation);
                        rs1.updateString("user_email", email);
                        rs1.insertRow();
                        out.println("Contact added successfully");
                    }
                }
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
