
import org.justceyin.expectations { 
    constrain 
}
import org.justceyin.expectations.constraints.providers { 
    anInteger 
}

"A buffered scanner for given input characters with given look ahead distance and back up distance."
by "Martin E. Nordberg III"
shared class Scanner(
    "The forward size of the buffer of scanned characters"
    Integer lookAheadSize,
    "The backup size of the buffer of scanned characters"
    Integer lookBehindSize,
    "The raw input"
    Iterator<Character> input
) {
    "The total size of the buffer within this scanner."
    value size = lookAheadSize + lookBehindSize;
    
    "A circular buffer of characters scanned."
    value characterBuffer = arrayOfSize( size, endOfInput );
    
    "The next character to be read (i.e. look ahead zero)."
    variable Integer nextToRead = 0;
    
    "The next character to be filled from the raw input."
    variable Integer nextToFill = 0;
    
    "Retrieve the next character from the input."
    shared default Character|Finished nextInputCharacter( Integer next ) {
        return input.next();
    }
    
    "Advance the input a given number of characters."
    shared void advance( Integer nCharacters ) {
        for ( i in 1..nCharacters ) {
            value ch = this.nextInputCharacter( this.nextToFill );
            switch ( ch )
                case ( is Finished ) {
                    characterBuffer.set( nextToFill, endOfInput );
                }
                case ( is Character ) {
                    characterBuffer.set( nextToFill, ch );
                }
            nextToFill = ( nextToFill + 1 ) % size;
        }
        nextToRead = ( nextToRead + nCharacters ) % size;
    }
    
    "Fills the scanner buffer up to the specified look ahead distance."
    shared void initialize() {
        this.advance( lookAheadSize );
        nextToRead = 0;
    }
    
    "Class defining a character returned from the scanner."
    shared default class ScannedCharacter(
        Integer index
    ) {
        "The scanned character."
        shared Character character {
            Character? result = outer.characterBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
    }

    "Retrieve the character a given look ahead distance in the buffer."
    shared default ScannedCharacter lookAhead( Integer n ) {
        constrain( n ).named( "n" ).toBe( anInteger.lessThan( lookAheadSize ) );
        constrain( n ).named( "n" ).toBe( anInteger.greaterThanOrEqualTo( -lookBehindSize ) );
        
        return ScannedCharacter( ( nextToRead + size + n ) % size );
    }

}

"Sentinel character indicating the end of input from the raw stream."
shared Character endOfInput = (0).character;
    
