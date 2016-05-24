package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Persoon {
    private UUID persoonId;
    private String naam;
    private String postcode;
    private String huisnummer;
    private Date geboorteDatum;
    private String telefoonnummer;
    private String emailadres;
}
