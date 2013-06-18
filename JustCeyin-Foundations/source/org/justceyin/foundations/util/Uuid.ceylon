
import org.justceyin.foundations.util.internal {
    makeRandomUuidImpl, 
    makeUuidFromStringImpl
}


"Class representing a 128 bit UUID (universally unique identifier)."
shared class Uuid(
    "The most significant 64 bits of the UUID"
    Integer mostSignificantBits, 
    "The least significant 64 bits of the UUID"
    Integer leastSignificantBits 
) {
    
    "Cached value of the string attribute."
    variable String? cachedString = null;
    
    "Compares the equality of two UUIDs."
    shared actual Boolean equals( Object other ) {
        if ( is Uuid other ) {
            return other.mostSignificantBits.equals( this.mostSignificantBits ) &&
                   other.leastSignificantBits.equals( this.leastSignificantBits );
        }
        
        return false;
    }
    
    "Computes a hash code for a UUID."
    shared actual Integer hash {
        return this.mostSignificantBits.or( this.leastSignificantBits );
    }
    
    "Converts this UUID to a string."
    shared actual String string {
        
        if ( exists result = this.cachedString ) {
            return result;
        }
        
        String result = 
            hexDigit( this.mostSignificantBits, 60 ) +
            hexDigit( this.mostSignificantBits, 56 ) + 
            hexDigit( this.mostSignificantBits, 52 ) + 
            hexDigit( this.mostSignificantBits, 48 ) + 
            hexDigit( this.mostSignificantBits, 44 ) + 
            hexDigit( this.mostSignificantBits, 40 ) + 
            hexDigit( this.mostSignificantBits, 36 ) + 
            hexDigit( this.mostSignificantBits, 32 ) + 
            "-" +
            hexDigit( this.mostSignificantBits, 28 ) + 
            hexDigit( this.mostSignificantBits, 24 ) + 
            hexDigit( this.mostSignificantBits, 20 ) + 
            hexDigit( this.mostSignificantBits, 16 ) + 
            "-" +
            hexDigit( this.mostSignificantBits, 12 ) + 
            hexDigit( this.mostSignificantBits, 8 ) + 
            hexDigit( this.mostSignificantBits, 4 ) + 
            hexDigit( this.mostSignificantBits, 0 ) + 
            "-" +
            hexDigit( this.leastSignificantBits, 60 ) +
            hexDigit( this.leastSignificantBits, 56 ) + 
            hexDigit( this.leastSignificantBits, 52 ) + 
            hexDigit( this.leastSignificantBits, 48 ) + 
            "-" +
            hexDigit( this.leastSignificantBits, 44 ) +
            hexDigit( this.leastSignificantBits, 40 ) + 
            hexDigit( this.leastSignificantBits, 36 ) + 
            hexDigit( this.leastSignificantBits, 32 ) + 
            hexDigit( this.leastSignificantBits, 28 ) +
            hexDigit( this.leastSignificantBits, 24 ) + 
            hexDigit( this.leastSignificantBits, 20 ) + 
            hexDigit( this.leastSignificantBits, 16 ) + 
            hexDigit( this.leastSignificantBits, 12 ) +
            hexDigit( this.leastSignificantBits, 8 ) + 
            hexDigit( this.leastSignificantBits, 4 ) + 
            hexDigit( this.leastSignificantBits, 0 ); 
        
        this.cachedString = result;
            
        return result;
    }

}

"Fixed array of hex digits for computing UUID digits."
String[] hexDigits = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"];

"Computes one hex digit of a UUID."
String hexDigit( Integer bits, Integer shift ) {
    value result = hexDigits[ bits.rightLogicalShift( shift ).and(#F) ];
    assert ( exists result );
    return result;
}
        
"Creates a new UUID with digits generated randomly."
shared Uuid makeRandomUuid() {
    return makeRandomUuidImpl();
}

"Constructs a UUID from its string representation."
shared Uuid makeUuidFromString( String uuidString ) {
    return makeUuidFromStringImpl( uuidString );
}
