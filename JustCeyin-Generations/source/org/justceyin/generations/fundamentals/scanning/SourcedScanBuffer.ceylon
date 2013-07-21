

shared class SourcedScanBuffer(
    "The forward size of the buffer of scanned characters"
    Integer lookAheadSize,
    "The backward size of the buffer of scanned characters"
    Integer lookBehindSize,
    "The raw input"
    Iterator<Character> input,
    "The name of the source"
    String sourceName
)
    extends ScanBuffer( lookAheadSize, lookBehindSize, input)
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
        ScanBuffer buffer,
        Integer index
    )
        extends super.ScannedCharacter( buffer, index )
    {
        
        shared Integer column {
            Integer? result = outer.columnBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
        shared Integer line {
            Integer? result = outer.lineBuffer[ index ];
            assert ( exists result );
            return result;
        }
        
        shared String sourceName {
            return outer.sourceName;
        }
        
    }

}