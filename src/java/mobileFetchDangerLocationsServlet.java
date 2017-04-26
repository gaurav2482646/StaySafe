
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

public class mobileFetchDangerLocationsServlet extends HttpServlet
{

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            //JDBC CODE
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root", "root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
           ResultSet rs = stmt.executeQuery("select * from unsafe_place where status='"+"approved"+"' ");
            if (rs.next())
            {
               rs.beforeFirst();
               while(rs.next())
               {
                   String id = rs.getInt("id")+"";
                   String locationName = rs.getString("location_name");
                   String locationAddress = rs.getString("location_address");
                   String longitude = rs.getString("longitude");
                   String latitude = rs.getString("latitude");
                   String marked_by = rs.getString("marked_by");
                   out.println(latitude + "^" + longitude + "^" + locationAddress + "^" + marked_by + "^" + id + "^" + locationName);
                  
               }
            }
           
 else
            {
                out.println("Location List is empty");
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }    
}
