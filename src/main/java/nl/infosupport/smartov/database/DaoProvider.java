package nl.infosupport.smartov.database;

import nl.infosupport.smartov.database.dao.Dao;

import javax.inject.Inject;
import javax.inject.Singleton;

@Singleton
final class DaoProvider {

    private final SmartOV app;

    @Inject
    public DaoProvider(SmartOV app) {
        this.app = app;
    }

    public <T extends Dao> T getDao(Class<T> target) {
        return app.getInstance(target);
    }
}