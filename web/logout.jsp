<%
    
    session.removeAttribute("user_email");
            session.removeAttribute("user_pic");
            session.removeAttribute("user_name");
            response.sendRedirect("user_login1.jsp");
    %>