package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Data
public abstract class Reisproduct {
    private UUID reisproductId;
    private String naam;
    private int geldigheid;
}
