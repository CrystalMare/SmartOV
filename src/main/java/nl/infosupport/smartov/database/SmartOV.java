package nl.infosupport.smartov.database;

import java.util.UUID;

/**
 * Created by user on 18-5-2016.
 */
public class SmartOV {

    public static void main(String[] args) {
        SmartOVDao dao = new SmartOVDummy();

        UUID sergio = UUID.randomUUID();

        System.out.println(dao.getSaldo(sergio));
    }
}
