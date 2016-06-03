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
import java.util.Map;
import java.util.UUID;

@WebServlet(urlPatterns = "/reisproduct-wijzigen")
public class ReisproductOpKaartWijzigenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        request.getRequestDispatcher("reisproduct-op-kaart-wijzigen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Map m = request.getParameterMap();
        String[] paramID = (String[]) m.get("productOpKaartId");
        UUID reisproductID = UUID.fromString(paramID[0]);

        String kaartnummer = request.getParameter("kaartnummer");

        SmartOV smartOV = new SmartOV();

        Kaart kaart = null;

        try(SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            kaart = dao.getCardByCardnumber(kaartnummer);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            dao.moveProduct(reisproductID, kaart.getKaartId());
            response.sendRedirect("/gekoppelde-kaarten");
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        out.close();

        //request.getRequestDispatcher("login.jsp").forward(request, response);
    }

}
