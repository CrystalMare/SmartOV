package nl.infosupport.smartov.database.model;

import lombok.*;

import java.util.UUID;

@Data
public class Regioproduct extends Kortingsreisproduct {
    private UUID regioId;

    public Regioproduct(UUID reisproductId, String naam, int geldigheid, int korting, UUID regioId) {
        super(reisproductId, naam, geldigheid, korting);
        this.regioId = regioId;
    }
}
