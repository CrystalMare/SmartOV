package nl.infosupport.smartov.database.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.UUID;


@EqualsAndHashCode(callSuper = true)
@Data
public class EenmaligReisproduct extends Reisproduct {
    BigDecimal toeslag;

    public EenmaligReisproduct(UUID reisproductId, String naam, int geldigheid, BigDecimal toeslag) {
        super(reisproductId, naam, geldigheid);
        this.toeslag = toeslag;
    }
}
