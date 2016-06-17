package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Reis;
import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = "/reishistorie")
public class ReishistoriePageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);

        UUID accountID = (UUID) session.getAttribute("accountid");
        Calendar cal = Calendar.getInstance();
        Date today = cal.getTime();
        cal.add(Calendar.YEAR, -10);
        Date prevYear = cal.getTime();
        List<Reis> reisList = null;

        try {
            reisList = dao.getJourneys(accountID, prevYear, today);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("reisList", reisList);
        request.getRequestDispatcher("reishistorie-inzien.jsp").forward(request, response);
    }

}
