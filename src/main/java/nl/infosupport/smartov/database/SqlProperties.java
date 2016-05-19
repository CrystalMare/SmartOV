package nl.infosupport.smartov.database;

import com.knockturnmc.api.util.NamedProperties;
import com.knockturnmc.api.util.Property;
import lombok.Getter;

public class SqlProperties extends NamedProperties {

    @Getter
    @Property(value = "sql.connectionstring", defaultvalue = "jdbc:sqlserver://94.23.181.86;Database\\=smartov;user=sa;password=OGSmartOV1!;")
    private String connectionString;
}
