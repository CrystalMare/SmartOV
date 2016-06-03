package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Kaart;
import nl.infosupport.smartov.database.model.Kortingsreisproduct;
import nl.infosupport.smartov.database.model.ProductOpKaart;
import nl.infosupport.smartov.database.model.Reisproduct;
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
import java.util.Map;
import java.util.UUID;

@WebServlet(urlPatterns = "/reisproduct-inzien")
public class ReisproductenVanKaartInzienPageController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        Map m = request.getParameterMap();
        String[] paramID = (String[]) m.get("kaartId");
        UUID kaartID = UUID.fromString(paramID[0]);
        SmartOV smartOV = new SmartOV();
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);
        List<ProductOpKaart> productOpKaartList = null;
        try {
            productOpKaartList = dao.getProducts(kaartID);
        } catch (SmartOVException e) {
            e.printStackTrace();
        }
        session.setAttribute("kaartId", kaartID);
        session.setAttribute("reisproduct", productOpKaartList);

        request.getRequestDispatcher("reisproducten-van-kaarten-inzien.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.close();

        //request.getRequestDispatcher("login.jsp").forward(request, response);
    }

}
