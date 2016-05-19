package nl.infosupport.smartov.database.dao;

public interface CloseableDao extends AutoCloseable, Dao {
    @Override
    void close();
}
