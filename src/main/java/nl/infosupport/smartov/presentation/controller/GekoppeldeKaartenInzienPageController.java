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
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = "/gekoppelde-kaarten")
public class GekoppeldeKaartenInzienPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);

        List<Kaart> kaartList = null;
        UUID uuid = null;
        Kaart kaart = null;

        switch (session.getAttribute("name").toString()) {
            case "KAARTHOUDER":
                uuid = (UUID) session.getAttribute("kaartid");
                try {
                    kaart = dao.getCard(uuid);

                } catch (SmartOVException e) {
                    e.printStackTrace();
                }

                session.setAttribute("kaartid", uuid);
                session.setAttribute("kaart", kaart);
                break;
            case "SALDOBEHEERDER":
                uuid = (UUID) session.getAttribute("accountid");

                try {
                    kaartList = dao.getCardsByAccountDetailed(uuid);
                } catch (SmartOVException e) {
                    e.printStackTrace();
                }

                session.setAttribute("accountid", uuid);
                session.setAttribute("kaartList", kaartList);
                break;
        }

        request.getRequestDispatcher("gekoppelde-kaarten-inzien.jsp").forward(request, response);
    }
}

