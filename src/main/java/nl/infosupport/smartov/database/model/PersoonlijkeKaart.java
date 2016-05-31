package nl.infosupport.smartov.database.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Data
public class PersoonlijkeKaart extends Kaart {
    private UUID persoonId;

    public PersoonlijkeKaart(UUID kaartId, UUID accountId, String kaartNummer, String kaartNaam, Date vervalDatum,
                             Date koppelDatum, UUID persoonId) {
        super(kaartId, accountId, kaartNummer, kaartNaam, vervalDatum, koppelDatum);
        this.persoonId = persoonId;
    }
}
