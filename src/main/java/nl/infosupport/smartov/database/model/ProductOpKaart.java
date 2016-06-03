package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductOpKaart {
    private UUID productOpKaartId;
    private Reisproduct reisproduct;
    private UUID kaartId;
    private UUID reisproductId;
    private Date koppeldatum;
    private Date vervaldatum;
}
