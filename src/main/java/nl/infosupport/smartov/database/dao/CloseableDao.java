package nl.infosupport.smartov.database.dao;

/**
 * Represents an auto-closeable DAO that can be used in a try-catch resource block
 *
 * @since 1.7
 */
public interface CloseableDao extends AutoCloseable, Dao {
    @Override
    void close();
}
