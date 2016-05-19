package nl.infosupport.smartov.database;

import nl.infosupport.smartov.database.dao.SmartOVDao;
import org.junit.Before;
import org.junit.Test;

import java.util.Date;

public class DatabaseTest {

    private SmartOV smartOV;

    @Before
    public void setUp() throws Exception {
        smartOV = new SmartOV();
    }

    @Test
    public void testConnection() throws Exception {
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);
        System.out.println(dao.createPerson("Steven", "6852LV", "36", new Date(840837600000L), "09061234567", "stevenvantuil@han.nl"));
    }


}
