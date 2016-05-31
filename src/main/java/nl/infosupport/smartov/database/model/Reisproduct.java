package nl.infosupport.smartov.database.model;

import lombok.*;

import java.util.Date;
import java.util.UUID;

@Data
public abstract class Reisproduct {
    private UUID reisproductId;
    private String naam;
    private int geldigheid;

    public Reisproduct(UUID reisproductId, String naam, int geldigheid) {
        this.reisproductId = reisproductId;
        this.naam = naam;
        this.geldigheid = geldigheid;
    }
}
