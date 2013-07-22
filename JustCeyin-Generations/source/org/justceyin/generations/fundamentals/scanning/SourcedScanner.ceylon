

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
    value size = lookAheadSize + lookBehindSize;
    
    value columnBuffer = arrayOfSize( size, 0 );

    value lineBuffer = arrayOfSize( size, 0 );

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
    
    shared actual class ScannedCharacter(
        Integer index
    )
        extends super.ScannedCharacter( index )
    {
        
        shared Integer sourceColumn {
            Integer? result = outer.columnBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
        shared Integer sourceLine {
            Integer? result = outer.lineBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
        shared String sourceName {
            return outer.sourceName;
        }
        
    }

    shared actual ScannedCharacter lookAhead( Integer n ) {
        value result = super.lookAhead( n );
        assert ( is ScannedCharacter result );
        return result;
    }

}
