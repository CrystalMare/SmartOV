package nl.infosupport.smartov.database;

import java.sql.Connection;

/**
 * Represents an SQL datasource
 */
interface SqlDatasource {

    /**
     * Returns an open connection to the database
     *
     * @return an open connection
     */
    Connection getConnection();
}
