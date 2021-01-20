package connectionpool;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class ConnectionPool {
    private static final Logger LOGGER = LogManager.getLogger(ConnectionPool.class.getName());
    private static ConnectionPool instance;
    private static BlockingQueue<ProxyConnection> proxyConnectionQueue;

    private static final DBResourceManager dbResourceManager = DBResourceManager.getInstance();
    private static final String DRIVER_NAME = dbResourceManager.getValue(DBParameter.DB_DRIVER);
    private static final String URL = dbResourceManager.getValue(DBParameter.DB_URL);
    private static final String USER = dbResourceManager.getValue(DBParameter.DB_USER);
    private static final String PASSWORD = dbResourceManager.getValue(DBParameter.DB_PASSWORD);
    private static final int POOL_SIZE = Integer.parseInt(dbResourceManager.getValue(DBParameter.DB_POOL_SIZE));

    private ConnectionPool() {
    }

    public static ConnectionPool getInstance() {
        ConnectionPool result = instance;
        if (result != null) {
            return result;
        }
        synchronized (ConnectionPool.class) {
            if (instance == null) {
                instance = new ConnectionPool();
                createPool();
            }
            return instance;
        }
    }

    private static void createPool() {

        try {
            Class.forName(DRIVER_NAME);

        } catch (ClassNotFoundException e) {
            LOGGER.error(e.getMessage(),e);
        }

        proxyConnectionQueue = new ArrayBlockingQueue<>(POOL_SIZE);
        for (int i = 0; i < POOL_SIZE; i++) {
            Connection connection = null;
            try {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                ProxyConnection proxyConnection = new ProxyConnection(connection);
                proxyConnectionQueue.put(proxyConnection);
            } catch (InterruptedException | SQLException e) {
                LOGGER.error(e.getMessage(),e);
            }
        }
        System.out.println("Connection queue size: " + proxyConnectionQueue.size());
        System.out.println("Connection Pool created");
    }

    public ProxyConnection getConnection() {
        ProxyConnection proxyConnection = null;
        try {
            proxyConnection = proxyConnectionQueue.take();
        } catch (InterruptedException e) {
            LOGGER.error(e.getMessage(),e);
        }
        System.out.println("Connection taken. Queue size: " + proxyConnectionQueue.size());
        return proxyConnection;
    }

    public void releaseConnection(ProxyConnection proxyConnection) {
        try {
            proxyConnectionQueue.put(proxyConnection);
        } catch (InterruptedException e) {
            LOGGER.error(e.getMessage(),e);
        }
        System.out.println("Connection released. Queue size: " + proxyConnectionQueue.size());
    }

    public void destroyConnections() {
        for (int i = 0; i < POOL_SIZE; i++) {
            ProxyConnection proxyConnection;
            try {
                proxyConnection = proxyConnectionQueue.take();
                proxyConnection.closeConnection();
            } catch (InterruptedException | SQLException e) {
                LOGGER.error(e.getMessage(),e);
            }
        }
        DriverManager.getDrivers().asIterator().forEachRemaining(driver -> {
            try {
                DriverManager.deregisterDriver(driver);
            } catch (SQLException e) {
                LOGGER.error(e.getMessage(),e);
            }
        });
    }
}
