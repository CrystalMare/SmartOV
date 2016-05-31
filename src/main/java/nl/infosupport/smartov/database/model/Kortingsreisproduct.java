package nl.infosupport.smartov.database.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.UUID;

@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Data
public class Kortingsreisproduct extends Reisproduct {
    private int korting;


    public Kortingsreisproduct(UUID reisproductId, String naam, int geldigheid, int korting) {
        super(reisproductId, naam, geldigheid);
        this.korting = korting;
    }
}
