
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mobileAddLatLngServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            String email = request.getParameter("email");
            Double lat = Double.parseDouble(request.getParameter("lat"));
            Double lng = Double.parseDouble(request.getParameter("lng"));
            
            //JDBC CODE
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from latlong");
            
            rs.moveToInsertRow();
            rs.updateString("email", email);
            rs.updateDouble("lat", lat);
            rs.updateDouble("lng", lng);
            rs.insertRow();
            
            
            

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

}
