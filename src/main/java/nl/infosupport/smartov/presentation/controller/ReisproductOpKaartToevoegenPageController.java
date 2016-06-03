package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Kaart;
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
import java.util.UUID;

@WebServlet(urlPatterns = "/reisproduct-toevoegen")
public class ReisproductOpKaartToevoegenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        HttpSession session = request.getSession();
        SmartOV smartOV = new SmartOV();
        List<Reisproduct> reisproductList = null;
        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            reisproductList = dao.getAllAvailableProducts((UUID) session.getAttribute("kaartId"));
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("reisproduct", reisproductList);

        request.getRequestDispatcher("reisproduct-op-kaart-toevoegen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String kaartnummer = request.getParameter("kaartnummer");
        UUID reisproduct = UUID.fromString(request.getParameter("reisproduct"));

        SmartOV smartOV = new SmartOV();
        Kaart kaart = null;

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            kaart = dao.getCardByCardnumber(kaartnummer);
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            dao.assignProductToCard(kaart.getKaartId(), reisproduct);
            response.sendRedirect("/gekoppelde-kaarten");
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        out.close();
    }

}
