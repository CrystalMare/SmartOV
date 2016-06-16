package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Kaart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet(urlPatterns = "/verwijder-kaart")
public class GekoppeldeKaartenVerwijderenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map m = request.getParameterMap();
        String[] paramID = (String[]) m.get("kaartId");
        UUID kaartID = UUID.fromString(paramID[0]);
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);
        try {
            dao.unbindCard(kaartID);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("/gekoppelde-kaarten");
    }

}
