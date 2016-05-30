package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public abstract class Reisproduct {
    UUID reisproductId;
    String naam;
    Date koppelDatum;
    Date vervalDatum;
}
