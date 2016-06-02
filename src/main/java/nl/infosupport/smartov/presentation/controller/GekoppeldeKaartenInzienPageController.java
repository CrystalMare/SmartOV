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

        UUID uuid = UUID.fromString(String.valueOf(session.getAttribute("accountid")));
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);
        List<Kaart> kaartList = null;
        try {
            kaartList = dao.getCardsByAccountDetailed(uuid);
        } catch (SmartOVException e) {
            e.printStackTrace();
        }
        session.setAttribute("accountid", uuid);
        session.setAttribute("kaart", kaartList);
        request.getRequestDispatcher("gekoppelde-kaarten-inzien.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();



        out.close();

        //request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}

