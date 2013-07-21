
import org.justceyin.specifications {
    ImperativeSpecification
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.expectations.constraints.providers { 
    aCharacter,
    anInteger,
    aString 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.generations.fundamentals.scanning { 
    SourcedScanBuffer 
}

"Specification exercises a scanner implementation with line and column tracking."
by "Martin E. Nordberg III"
shared class SourcedScanBufferSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "SourcedScanBuffer Specification";

    "A sourced scanner returns correct line and column numbers."
    void testTypicalUsage( void outcomes( ConstraintCheckResult* results ) ) {
        String input = "0123\n456\n789";
        
        SourcedScanBuffer scanner = SourcedScanBuffer( 4, 2, input.iterator(), "Example" );
        
        scanner.initialize();
        
        value ch0 = scanner.lookAhead(0);
        value ch1 = scanner.lookAhead(1);
        value ch2 = scanner.lookAhead(2);
        value ch3 = scanner.lookAhead(3);
        
        assert ( is SourcedScanBuffer.ScannedCharacter ch0 );
        assert ( is SourcedScanBuffer.ScannedCharacter ch1 );
        assert ( is SourcedScanBuffer.ScannedCharacter ch2 );
        assert ( is SourcedScanBuffer.ScannedCharacter ch3 );
        
        outcomes( 
            expect( ch0.character ).named( "lookAhead[0]" ).toBe( aCharacter.withValue('0') ),
            expect( ch0.line ).named( "lookAhead[0] line" ).toBe( anInteger.withValue(1) ),
            expect( ch0.column ).named( "lookAhead[0] column" ).toBe( anInteger.withValue(1) ),
            expect( ch0.sourceName ).named( "lookAhead[0] source name" ).toBe( aString.withValue("Example") ),
            expect( ch1.character ).named( "lookAhead[1]" ).toBe( aCharacter.withValue('1') ),
            expect( ch1.line ).named( "lookAhead[1] line" ).toBe( anInteger.withValue(1) ),
            expect( ch1.column ).named( "lookAhead[1] column" ).toBe( anInteger.withValue(2) ),
            expect( ch2.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('2') ),
            expect( ch2.line ).named( "lookAhead[2] line" ).toBe( anInteger.withValue(1) ),
            expect( ch2.column ).named( "lookAhead[2] column" ).toBe( anInteger.withValue(3) ),
            expect( ch3.character ).named( "lookAhead[3]" ).toBe( aCharacter.withValue('3') ),
            expect( ch3.line ).named( "lookAhead[3] line" ).toBe( anInteger.withValue(1) ),
            expect( ch3.column ).named( "lookAhead[3] column" ).toBe( anInteger.withValue(4) )
        );

        scanner.advance( 2 );
        
        value ch2a = scanner.lookAhead(0);
        value ch3a = scanner.lookAhead(1);
        value ch4a = scanner.lookAhead(2);
        value ch5a = scanner.lookAhead(3);

        assert ( is SourcedScanBuffer.ScannedCharacter ch2a );
        assert ( is SourcedScanBuffer.ScannedCharacter ch3a );
        assert ( is SourcedScanBuffer.ScannedCharacter ch4a );
        assert ( is SourcedScanBuffer.ScannedCharacter ch5a );

        outcomes( 
            expect( ch0.character ).named( "lookAhead[0]" ).toBe( aCharacter.withValue('0') ),
            expect( ch0.line ).named( "lookAhead[0] line" ).toBe( anInteger.withValue(1) ),
            expect( ch0.column ).named( "lookAhead[0] column" ).toBe( anInteger.withValue(1) ),
            expect( ch0.sourceName ).named( "lookAhead[0] source name" ).toBe( aString.withValue("Example") ),
            expect( ch1.character ).named( "lookAhead[1]" ).toBe( aCharacter.withValue('1') ),
            expect( ch1.line ).named( "lookAhead[1] line" ).toBe( anInteger.withValue(1) ),
            expect( ch1.column ).named( "lookAhead[1] column" ).toBe( anInteger.withValue(2) ),
            expect( ch2.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('2') ),
            expect( ch2.line ).named( "lookAhead[2] line" ).toBe( anInteger.withValue(1) ),
            expect( ch2.column ).named( "lookAhead[2] column" ).toBe( anInteger.withValue(3) ),
            expect( ch3.character ).named( "lookAhead[3]" ).toBe( aCharacter.withValue('3') ),
            expect( ch3.line ).named( "lookAhead[3] line" ).toBe( anInteger.withValue(1) ),
            expect( ch3.column ).named( "lookAhead[3] column" ).toBe( anInteger.withValue(4) ),
            expect( ch2a.character ).named( "lookAhead[2a]" ).toBe( aCharacter.withValue('2') ),
            expect( ch2a.line ).named( "lookAhead[2a] line" ).toBe( anInteger.withValue(1) ),
            expect( ch2a.column ).named( "lookAhead[2a] column" ).toBe( anInteger.withValue(3) ),
            expect( ch2a.sourceName ).named( "lookAhead[2a] source name" ).toBe( aString.withValue("Example") ),
            expect( ch3a.character ).named( "lookAhead[3a]" ).toBe( aCharacter.withValue('3') ),
            expect( ch3a.line ).named( "lookAhead[3a] line" ).toBe( anInteger.withValue(1) ),
            expect( ch3a.column ).named( "lookAhead[3a] column" ).toBe( anInteger.withValue(4) ),
            expect( ch4a.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('4') ),
            expect( ch4a.line ).named( "lookAhead[4a] line" ).toBe( anInteger.withValue(2) ),
            expect( ch4a.column ).named( "lookAhead[4a] column" ).toBe( anInteger.withValue(1) ),
            expect( ch5a.character ).named( "lookAhead[5a]" ).toBe( aCharacter.withValue('5') ),
            expect( ch5a.line ).named( "lookAhead[5a] line" ).toBe( anInteger.withValue(2) ),
            expect( ch5a.column ).named( "lookAhead[5a] column" ).toBe( anInteger.withValue(2) )
        );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testTypicalUsage
    };

}
