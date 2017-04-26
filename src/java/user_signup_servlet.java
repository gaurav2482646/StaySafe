
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.*;
import javax.servlet.http.HttpSession;

@MultipartConfig
public class user_signup_servlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        try {
            String email = request.getParameter("email");
            String fn = request.getParameter("firstname");
            String ln = request.getParameter("lastname");
            String phone_no = request.getParameter("phone_no");
            String sec_ques = request.getParameter("security_question");
            String sec_ans = request.getParameter("security_answer");
            String password = request.getParameter("password");
            String filepath = "";
            String absolutepath = request.getServletContext().getRealPath("/profile_pics");
            Collection<Part>parts= request.getParts();
            for (Part part : parts) {

                String filename = vmm2.FileUploader.savefileonserver(part, absolutepath);
                if (filename.equals("not-a-file")) {

                } else {
                        filepath = "./profile_pics/"+filename;
                }
            }

            //JDBC
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/admin", "root","root");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("select * from user_signup where email='" + email + "'");
            if (rs.next()) 
            {
                response.sendRedirect("user_signup1.jsp?msg=email id already exists");
            }
            else
            {
                    String AB="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
                    SecureRandom rmd=new SecureRandom();
                    StringBuffer sb=new StringBuffer(6);
                    for(int i=0;i<8;i++)
                    {
                        sb.append(AB.charAt(rmd.nextInt(AB.length())));
                    }
                     String pwd = sb.toString();
                rs.moveToInsertRow();
                rs.updateString("email",email);
                rs.updateString("firstname",fn );
                rs.updateString("lastname", ln);
                rs.updateString("phoneno",phone_no );
                rs.updateString("security_ques",sec_ques );
                rs.updateString("security_ans",sec_ans );
                rs.updateString("password",password);
                rs.updateString("validation_code", pwd);
                rs.updateString("profilepic",filepath );
                rs.insertRow();
                
//               session.setAttribute("user_email", email);
                vmm2.SimpleMailDemo s= new vmm2.SimpleMailDemo(email,"Welcome new user","Dear "+fn+",\nYou have successfully created new account on "
                                                                                    + "www.staysafe.com. Your system generated valiation code is "+pwd+".Please verify your account with this code .");
                response.sendRedirect("user_login1.jsp?msg=Your verification has been sent to registered email.Login after Verfying your account.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
