package nl.infosupport.smartov.database;

import lombok.extern.log4j.Log4j;

import java.sql.Connection;
import java.sql.SQLException;

@Log4j
abstract class SqlConnector implements AutoCloseable {

    protected final Connection connection;

    SqlConnector(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void close() {
        try {
            connection.close();
        } catch (SQLException e) {
            log.error("Failed to close connection", e);
        }
    }
}
