package nl.infosupport.smartov.presentation.controller;


import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

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

        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
        Date date = null;
        try {
            date = format.parse(geboortedatum);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        String telefoonnummer = request.getParameter("telefoonnummer");
        String emailadres = request.getParameter("emailadres");
        String kaartnaam = request.getParameter("kaartnaam");

        SmartOV smartOV = new SmartOV();

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            UUID persoonid = dao.createPerson(naam, postcode, huisnummer, date, telefoonnummer, emailadres);
            dao.createCard(persoonid , kaartnaam);
            response.sendRedirect("/dashboard");

        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        out.close();
    }
}
