package nl.infosupport.smartov.database;

import lombok.extern.log4j.Log4j;
import nl.infosupport.smartov.database.dao.Transactional;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@Log4j
abstract class SqlConnector implements AutoCloseable, Transactional {

    protected final Connection connection;

    SqlConnector(Connection connection) {
        this.connection = connection;
        try {
            PreparedStatement ps = connection.prepareStatement("BEGIN TRANSACTION;");
            ps.execute();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void rollback() {
        try {
            PreparedStatement ps = connection.prepareStatement("ROLLBACK TRANSACTION;");
            ps.execute();
            ps.close();

            ps = connection.prepareStatement("BEGIN TRANSACTION;");
            ps.execute();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void close() {
        try {
            connection.commit();
            connection.close();
        } catch (SQLException e) {
            log.error("Failed to close connection", e);
        }
    }
}
