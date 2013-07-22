

"A buffered scanner for given input characters with given look ahead distance and back up distance.
 Scanner outputs include source name, line, and column number."
by "Martin E. Nordberg III"
shared class SourcedScanner(
    "The forward size of the buffer of scanned characters"
    Integer lookAheadSize,
    "The backward size of the buffer of scanned characters"
    Integer lookBehindSize,
    "The raw input"
    Iterator<Character> input,
    "The name of the source"
    String sourceName
)
    extends Scanner( lookAheadSize, lookBehindSize, input)
{
    "The total size of the scanner output buffer."
    value size = lookAheadSize + lookBehindSize;
    
    "A buffer containing column numbers."
    value columnBuffer = arrayOfSize( size, 0 );

    "A buffer containing line numbers."
    value lineBuffer = arrayOfSize( size, 1 );

    "Retrieve the next character from the input. Also track the line number and column number."
    shared actual default Character|Finished nextInputCharacter( Integer next ) {
        Character|Finished result = super.nextInputCharacter( next );
        
        if ( result is Character ) {
            Integer prev = ( next + this.size - 1 ) % this.size;
            Integer? prevColumn = columnBuffer[prev];
            Integer? prevLine = lineBuffer[prev];
            
            assert ( exists prevColumn );
            assert ( exists prevLine );
            
            if ( result == '\n' ) {
                columnBuffer.set( next, 1 );
                lineBuffer.set( next, prevLine + 1 );
            }
            else {
                columnBuffer.set( next, prevColumn + 1 );
                lineBuffer.set( next, prevLine );
            }
        }
        
        return result;
    }
    
    "Class defining a character returned from the scanner, including its source in the input."
    shared actual class ScannedCharacter(
        "Index into the scanner's buffer where the character is held temporarily."
        Integer index
    )
        extends super.ScannedCharacter( index )
    {

        "The column number of this character in its source (1..n)."        
        shared Integer sourceColumn {
            Integer? result = outer.columnBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
        "The line number of this character in its source (1..n)."
        shared Integer sourceLine {
            Integer? result = outer.lineBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
        "The name of the source of this character."
        shared String sourceName {
            return outer.sourceName;
        }
        
    }

    "Retrieve the character a given look ahead distance in the buffer."
    shared actual ScannedCharacter lookAhead( Integer n ) {
        value result = super.lookAhead( n );
        assert ( is ScannedCharacter result ); // TBD: should not be needed (whole method)
        return result;
    }

}
