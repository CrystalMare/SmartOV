package nl.infosupport.smartov.database.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.math.BigInteger;


@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class EenmaligReisproduct extends Reisproduct {
    BigInteger toeslag;
}
