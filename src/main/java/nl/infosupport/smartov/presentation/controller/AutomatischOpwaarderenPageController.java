package nl.infosupport.smartov.presentation.controller;

import nl.infosupport.smartov.database.SmartOV;
import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.dao.SmartOVDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.UUID;

@WebServlet(urlPatterns = "automatisch-opwaarderen")
public class AutomatischOpwaarderenPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        request.getRequestDispatcher("automatisch-opwaarderen.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        BigInteger bedrag = BigInteger.valueOf(Long.parseLong(request.getParameter("saldo")));
        SmartOV smartOV = new SmartOV();

        UUID uuid = UUID.fromString("E6D77591-D3D9-4B2A-A855-8961A71DFEE7");

        try (SmartOVDao dao = smartOV.getInstance(SmartOVDao.class)) {
            dao.setAutoRenewal(uuid, "NL91ABNA0417164300", bedrag);
            response.sendRedirect("/dashboard");
        } catch (SmartOVException e) {
            throw new RuntimeException(e);
        }
        out.close();
    }
}
