package nl.infosupport.smartov.presentation.controller.session;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionHandler {

    public SessionHandler() {}

    public void getUserSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String user = null;

        if (session.getAttribute("name").toString().isEmpty())
            response.sendRedirect("/");
        else
            user = (String) session.getAttribute("name");

        Cookie[] cookies = request.getCookies();
        if (cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("name")) cookie.getValue();
                if(cookie.getName().equals("JSESSIONID")) cookie.getValue();
            }
        }

        request.setAttribute("name", user);
    }

}
