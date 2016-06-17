package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Kaart;
import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = "/reizen")
public class ReizenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);

        List<Kaart> kaartList = null;
        UUID persoonID = (UUID) session.getAttribute("personid");
        try {
             kaartList = dao.getCardsByOwner(persoonID);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("kaartList", kaartList);

        request.getRequestDispatcher("reizen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        UUID kaart = UUID.fromString(request.getParameter("kaart"));
        UUID station = UUID.fromString(request.getParameter("station"));

        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);

        try {
            dao.travel(kaart, station);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }
        response.sendRedirect("/reizen");
        out.close();
    }
}
