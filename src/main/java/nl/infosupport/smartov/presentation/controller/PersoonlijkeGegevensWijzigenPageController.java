package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Persoon;
import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@WebServlet(urlPatterns = "/persoonlijke-gegevens-wijzigen")
public class PersoonlijkeGegevensWijzigenPageController extends HttpServlet {

   private final SimpleDateFormat FORMAT = new SimpleDateFormat("dd-MM-yyyy");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        UUID uuid = UUID.fromString("E6D9FBF2-6E2E-44C9-B68F-7389D47F6A78");

        SmartOV smartOV = new SmartOV();

        Persoon persoon = null;

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            persoon = dao.getPerson(uuid);
        } catch (SmartOVException e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        session.setAttribute("naam", persoon.getNaam());
        session.setAttribute("postcode", persoon.getPostcode());
        session.setAttribute("huisnummer", persoon.getHuisnummer());
        session.setAttribute("geboortedatum", FORMAT.format(persoon.getGeboorteDatum()));
        session.setAttribute("telefoonnummer", persoon.getTelefoonnummer());
        session.setAttribute("email", persoon.getEmailadres());

        request.getRequestDispatcher("persoonlijke-gegevens-wijzigen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String naam = request.getParameter("naam");
        String postcode = request.getParameter("postcode");
        String huisnummer = request.getParameter("huisnummer");
        String telefoonnummer = request.getParameter("telefoonnummer");
        String email = request.getParameter("email");

        String geboortedatum = request.getParameter("geboortedatum");


        Date date = null;
        try {
            date = FORMAT.parse(geboortedatum);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        SmartOV smartOV = new SmartOV();

        UUID uuid = UUID.fromString("E6D9FBF2-6E2E-44C9-B68F-7389D47F6A78");

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            dao.updatePerson(uuid, naam, postcode, huisnummer, date, telefoonnummer, email);
            response.sendRedirect("/dashboard");
        } catch (SmartOVException e) {
            e.printStackTrace();
        }
    }
}
