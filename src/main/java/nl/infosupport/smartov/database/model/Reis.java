package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reis {
    private UUID reisId;
    private UUID beginpunt;
    private UUID eindpunt;
    private int prijs;
    private Date incheckDatum;
    private Date uitcheckDatum;
    private String naam;
}
