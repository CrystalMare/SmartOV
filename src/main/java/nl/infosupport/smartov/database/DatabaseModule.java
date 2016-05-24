package nl.infosupport.smartov.database;

import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import com.knockturnmc.api.util.ConfigurationUtils;
import nl.infosupport.smartov.database.dao.SmartOVDao;

final class DatabaseModule extends AbstractModule {

    @Override
    protected void configure() {
        bind(SqlDatasource.class).to(SqlDatabase.class);
        bind(SmartOVDao.class).to(SmartConnector.class);
    }

    @Provides
    public SqlProperties getProperties() {
        return ConfigurationUtils.loadConfiguration(getClass().getClassLoader(), "config.properties", SqlProperties.class);
    }
}
