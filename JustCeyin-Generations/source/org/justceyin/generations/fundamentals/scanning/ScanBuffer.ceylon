
shared class ScanBuffer(
    "The forward size of the buffer of scanned characters"
    Integer lookAheadSize,
    "The backward size of the buffer of scanned characters"
    Integer lookBehindSize,
    "The raw input"
    Iterator<Character> input
) {
    value size = lookAheadSize + lookBehindSize;
    value characterBuffer = arrayOfSize( size, endOfInput );
    
    variable Integer nextToRead = 0;
    variable Integer nextToFill = 0;
    
    shared default Character|Finished nextInputCharacter( Integer next ) {
        return input.next();
    }
    
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
    
    shared void initialize() {
        this.advance( lookAheadSize );
        nextToRead = 0;
    }
    
    shared default class ScannedCharacter(
        ScanBuffer buffer,
        Integer index
    ) {
        
        shared Character character {
            Character? result = outer.characterBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
    }

    shared ScannedCharacter lookAhead( Integer n ) {
        return ScannedCharacter( this, ( nextToRead + n ) % size );
    }

}

shared Character endOfInput = (0).character;
    
