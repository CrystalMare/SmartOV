package nl.infosupport.smartov.database.model;

import lombok.*;

import java.util.UUID;

@Data
public class Kortingsreisproduct extends Reisproduct {
    private int korting;

    @Builder
    public Kortingsreisproduct(UUID reisproductId, String naam, int geldigheid, int korting) {
        super(reisproductId, naam, geldigheid);
        this.korting = korting;
    }
}
