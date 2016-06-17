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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

@WebServlet(urlPatterns = "/kostenoverzicht")
public class KostenoverzichtInzienPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);

        BigDecimal cost;

        UUID accountID = (UUID) session.getAttribute("accountid");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.YEAR, -10);
        Date prevYear = cal.getTime();

        try {
            cost = dao.getCosts(accountID, prevYear, new Date());
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("cost", String.format("%.2f", cost.floatValue()));
        request.getRequestDispatcher("kostenoverzicht-inzien.jsp").forward(request, response);
    }
}
