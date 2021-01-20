package servlet;

import connectionpool.ConnectionPool;
import service.Service;
import service.ServiceFactory;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CafeServlet extends HttpServlet {

    @Override
    public void init() {
        ConnectionPool.getInstance();
    }

    @Override
    public void destroy() {
        ConnectionPool.getInstance().destroyConnections();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp){
        String requestString = req.getParameter("service");
        Service service = ServiceFactory.getService(requestString);
        service.execute(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        doGet(req, resp);
    }
}
