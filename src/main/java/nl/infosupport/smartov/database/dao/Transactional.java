package nl.infosupport.smartov.database.dao;

public interface Transactional {
    void rollback();
}
