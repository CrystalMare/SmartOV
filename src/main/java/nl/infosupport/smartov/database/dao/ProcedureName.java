package nl.infosupport.smartov.database.dao;

import java.lang.annotation.*;

/**
 * Represents an annotated method that links to a procedure
 */
@Documented
@Retention(RetentionPolicy.SOURCE)
@Target(ElementType.METHOD)
@interface ProcedureName {
    /**
     * Gets the name of the procedure
     * @return the procedure name
     */
    String value();
}
