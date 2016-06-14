package nl.infosupport.smartov.presentation.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

@WebServlet(urlPatterns = "/dashboard")
public class DashboardPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        UUID uuid = null;

        switch (session.getAttribute("name").toString()) {
            case "KAARTHOUDER":
                uuid = UUID.fromString("535774F0-273D-48E1-A567-05A45813BF24");
                session.setAttribute("personid", uuid);
                break;
            case "SALDOBEHEERDER":
                uuid = UUID.fromString("E6D77591-D3D9-4B2A-A855-8961A71DFEE7");
                session.setAttribute("accountid", uuid);
                break;
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

}
