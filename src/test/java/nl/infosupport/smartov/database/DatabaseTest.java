package nl.infosupport.smartov.database;

import nl.infosupport.smartov.database.dao.SmartOVDao;
import org.junit.Before;
import org.junit.Test;

import java.util.UUID;

public class DatabaseTest {

    private SmartOV smartOV;

    @Before
    public void setUp() throws Exception {
        smartOV = new SmartOV();
    }

    @Test
    public void testConnection() throws Exception {
        SmartOVDao dao = smartOV.getInstance(SmartOVDao.class);
        //UUID uuid = dao.createPerson("Steven", "6852LV", "36", new Date(840837600000L), "09061234567", "stevenvantuil@han.nl");
//        dao.updatePerson(UUID.fromString("936AD311-0875-40E5-8CCE-B1F0F9F3F4CB"), "Steven2", "6852LV", "36", new Date(840837600000L), "09061234567", "stevenvantuil@han.nl");
//        dao.createCard(UUID.fromString("936AD311-0875-40E5-8CCE-B1F0F9F3F4CB"), "Testkaartje");
        System.out.println(dao.getPerson(UUID.fromString("936AD311-0875-40E5-8CCE-B1F0F9F3F4CB")));
    }


}
