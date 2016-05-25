package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Kaart {
    UUID kaartId;
    UUID accountId;
    String kaartNummer;
    String kaartNaam;
    Date vervalDatum;
    Date koppelDatum;
}
