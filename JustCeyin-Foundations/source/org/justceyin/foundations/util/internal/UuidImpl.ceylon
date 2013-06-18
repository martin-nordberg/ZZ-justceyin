
import java.util {
    JavaUUID = UUID {
        javaRandomUuid = randomUUID,
        javaUuidFromString = fromString
    }
}
import org.justceyin.foundations.util {
    Uuid
}

"Creates a new Uuid using the random UUID capability of Java."
shared Uuid makeRandomUuidImpl() {
    value result = javaRandomUuid();
    return Uuid( result.mostSignificantBits, result.leastSignificantBits );
}

"Creates a new Uuid from its string representation."
shared Uuid makeUuidFromStringImpl( String uuidString ) {
    value result = javaUuidFromString( uuidString );
    return Uuid( result.mostSignificantBits, result.leastSignificantBits );
}
