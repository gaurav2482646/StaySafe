
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class mobileLogInServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            //JDBC
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from user_signup where email='" + email + "' and password='" + password + "'");
            if (rs.next())
            {
                String valid = rs.getString("varified_user");
                if (valid.equals("yes"))
                {    
                    out.println("Login Successful");
                } 
                else if(valid.equals("no"))
                {
                    out.println("Login failed, verify your account first");
                }
            } 
            else
            {
                out.println("Invalid Email or Password");
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
