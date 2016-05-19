package nl.infosupport.smartov.presentation.controller;


import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/kaart-kopen")
public class KaartKopenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        request.getRequestDispatcher("kaart-kopen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String naam = request.getParameter("naam");
        String postcode = request.getParameter("postcode");
        String huisnummer = request.getParameter("huisnummer");
        String geboortedatum = request.getParameter("geboortedatum");
        String telefoonnummer = request.getParameter("telefoonnummer");
        String emailadres = request.getParameter("emailadres");

        /*
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);
        dao.createPerson(naam, postcode, huisnummer, new Date(geboortedatum), telefoonnummer, emailadres);
        */

        out.close();
    }
}
