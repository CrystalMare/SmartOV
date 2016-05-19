package nl.infosupport.smartov.database;

import java.sql.SQLException;

public class SmartOVException extends SQLException {

    public SmartOVException(SQLException cause) {
        super(cause);
    }
}
