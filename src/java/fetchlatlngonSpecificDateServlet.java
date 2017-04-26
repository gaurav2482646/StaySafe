
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sun.security.pkcs11.wrapper.Functions;

public class fetchlatlngonSpecificDateServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            String email = request.getParameter("email");
            String date = request.getParameter("date");
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from latlong where email = '" + email + "' and date_time like '" + date + "%'");

            String points = "";

            if (rs.next())
            {
                rs.beforeFirst();
                while (rs.next())
                {
                    Double lat = rs.getDouble("lat");
                    Double lng = rs.getDouble("lng");
                    points = points + lat + "^" + lng + "^";
                }
                out.println(points.substring(0, (points.length() - 1)));

            } else
            {
                out.println("Cannot track the device on this day");
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
