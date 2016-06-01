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
import java.util.UUID;

@WebServlet(urlPatterns = "/gekoppelde-kaarten-toevoegen")
public class GekoppeldeKaartenToevoegenPageController extends HttpServlet {

    private SessionHandler sessionHandler = new SessionHandler();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        sessionHandler.getUserSession(request, response);
        HttpSession session = request.getSession();
        UUID accountid = UUID.fromString(String.valueOf(session.getAttribute("accountid")));
        session.setAttribute("accountid", accountid);
        request.getRequestDispatcher("gekoppelde-kaarten-toevoegen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        UUID accountid = UUID.fromString(String.valueOf(session.getAttribute("accountid")));
        String kaartnummer = request.getParameter("kaartnummer");

        SmartOV smartOV = new SmartOV();
        Kaart kaart = null;

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            kaart = dao.getCardByCardnumber(kaartnummer);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            dao.bindCard(kaart.getKaartId(), accountid);
            response.sendRedirect("/gekoppelde-kaarten");
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        out.close();
    }

}
