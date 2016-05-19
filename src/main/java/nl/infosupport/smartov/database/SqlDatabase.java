package nl.infosupport.smartov.database;

import lombok.extern.log4j.Log4j;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Log4j
@Singleton
class SqlDatabase implements SqlDatasource {

    private final SqlProperties properties;

    @Inject
    public SqlDatabase(SqlProperties properties) throws ClassNotFoundException {
        this.properties = properties;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }

    public Connection getConnection() {
        try {
            return DriverManager.getConnection(properties.getConnectionString());
        } catch (SQLException e) {
            log.error("Failed to get connection", e);
            throw new RuntimeException(e);
        }
    }
}
