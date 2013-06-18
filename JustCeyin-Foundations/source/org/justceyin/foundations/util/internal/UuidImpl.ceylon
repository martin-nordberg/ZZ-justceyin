
import java.util {
    JavaUUID = UUID {
        javaRandomUUID = randomUUID
    }
}
import org.justceyin.foundations.util {
    Uuid
}

"Implementation of interface Uuid based upon Java UUIDs."
class UuidImpl( JavaUUID uuid )
    satisfies Uuid 
{
    shared actual Boolean equals( Object other ) {
        if ( is UuidImpl other ) {
            return other.uuid.equals( this.uuid );
        }
        
        return false;
    }
    
    shared actual String string {
        return uuid.string;
    }
}

"Creates a new Uuid."
shared Uuid makeUuidImpl() {
    return UuidImpl( javaRandomUUID() ); 
}
