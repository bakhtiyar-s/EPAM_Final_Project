package dao;

import connectionpool.ProxyConnection;
import java.sql.SQLException;

public abstract class BaseDAO {

    public void releaseConnection(ProxyConnection connection) throws SQLException {
        if (connection != null) {
            connection.setAutoCommit(true);
            connection.close();
        }
    }
}
