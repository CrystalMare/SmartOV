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

        List<Reis> reisFromList;
        try {
            reisFromList = dao.getJourneysFromLocation(UUID.fromString("9C6FBCBC-5055-4A7D-A4FD-DBC496C099D1"), UUID.fromString("6D36C50C-2810-44E1-9117-37432FA4D427"));
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("reisFromList", reisFromList);
        request.getRequestDispatcher("reishistorie-inzien.jsp").forward(request, response);
    }

}
