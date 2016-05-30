package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.math.BigInteger;
import java.util.UUID;


@Data
public class EenmaligReisproduct extends Reisproduct {
    BigInteger toeslag;

    public EenmaligReisproduct(UUID reisproductId, String naam, int geldigheid) {
        super(reisproductId, naam, geldigheid);
    }
}
