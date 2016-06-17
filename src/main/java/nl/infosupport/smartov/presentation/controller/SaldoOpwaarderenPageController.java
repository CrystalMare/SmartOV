package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.presentation.controller.session.SessionHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.*;

@WebServlet(urlPatterns = "/saldo-opwaarderen")
public class SaldoOpwaarderenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        SessionHandler sessionHandler = new SessionHandler();
        sessionHandler.getUserSession(request, response);

        UUID uuid = UUID.fromString("E6D77591-D3D9-4B2A-A855-8961A71DFEE7");

        SmartOV smartOV = new SmartOV();

        String saldo = "";

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            saldo = String.format("%.2f", dao.getSaldo(uuid));
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }

        HttpSession session = request.getSession();
        session.setAttribute("saldo", saldo);
        session.setMaxInactiveInterval(30 * 60);

        request.getRequestDispatcher("saldo-opwaarderen.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String saldo = request.getParameter("saldo");
        SmartOV smartOV = new SmartOV();

        UUID uuid = UUID.fromString("E6D77591-D3D9-4B2A-A855-8961A71DFEE7");

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            dao.addSaldo(uuid, new BigDecimal(saldo));
            response.sendRedirect("/saldo-opwaarderen");
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }
        out.close();
    }

}
