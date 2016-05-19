package nl.infosupport.smartov.database;

import com.google.inject.Binder;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Module;

public class SmartOV implements Module {

    private final Injector injector;

    public SmartOV() {
        this.injector = Guice.createInjector(this, new DatabaseModule());
    }

    public SmartOV getInstance() {
        return this;
    }

    public <T> T getInstance(Class<T> target) {
        return injector.getInstance(target);
    }

    @Override
    public void configure(Binder binder) {

    }
}
