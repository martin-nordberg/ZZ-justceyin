
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
    SourcedScanner 
}

"Specification exercises a scanner implementation with line and column tracking."
by "Martin E. Nordberg III"
shared class SourcedScannerSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "SourcedScanner Specification";

    "A sourced scanner returns correct line and column numbers."
    void testTypicalUsage( void outcomes( ConstraintCheckResult* results ) ) {
        String input = "0123\n567\n890";
        
        SourcedScanner scanner = SourcedScanner( 4, 2, input.iterator(), "Example" );
        
        scanner.initialize();
        
        value ch0 = scanner.lookAhead(0);
        value ch1 = scanner.lookAhead(1);
        value ch2 = scanner.lookAhead(2);
        value ch3 = scanner.lookAhead(3);
        
        outcomes( 
            expect( ch0.character ).named( "lookAhead[0]" ).toBe( aCharacter.withValue('0') ),
            expect( ch0.sourceLine ).named( "lookAhead[0] line" ).toBe( anInteger.withValue(1) ),
            expect( ch0.sourceColumn ).named( "lookAhead[0] column" ).toBe( anInteger.withValue(1) ),
            expect( ch0.sourceName ).named( "lookAhead[0] source name" ).toBe( aString.withValue("Example") ),
            expect( ch1.character ).named( "lookAhead[1]" ).toBe( aCharacter.withValue('1') ),
            expect( ch1.sourceLine ).named( "lookAhead[1] line" ).toBe( anInteger.withValue(1) ),
            expect( ch1.sourceColumn ).named( "lookAhead[1] column" ).toBe( anInteger.withValue(2) ),
            expect( ch2.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('2') ),
            expect( ch2.sourceLine ).named( "lookAhead[2] line" ).toBe( anInteger.withValue(1) ),
            expect( ch2.sourceColumn ).named( "lookAhead[2] column" ).toBe( anInteger.withValue(3) ),
            expect( ch3.character ).named( "lookAhead[3]" ).toBe( aCharacter.withValue('3') ),
            expect( ch3.sourceLine ).named( "lookAhead[3] line" ).toBe( anInteger.withValue(1) ),
            expect( ch3.sourceColumn ).named( "lookAhead[3] column" ).toBe( anInteger.withValue(4) )
        );

        scanner.advance( 2 );
        
        value ch2a = scanner.lookAhead(0);
        value ch3a = scanner.lookAhead(1);
        value ch4a = scanner.lookAhead(2);
        value ch5a = scanner.lookAhead(3);

        outcomes( 
            expect( ch0.character ).named( "lookAhead[0]" ).toBe( aCharacter.withValue('0') ),
            expect( ch0.sourceLine ).named( "lookAhead[0] line" ).toBe( anInteger.withValue(1) ),
            expect( ch0.sourceColumn ).named( "lookAhead[0] column" ).toBe( anInteger.withValue(1) ),
            expect( ch0.sourceName ).named( "lookAhead[0] source name" ).toBe( aString.withValue("Example") ),
            expect( ch1.character ).named( "lookAhead[1]" ).toBe( aCharacter.withValue('1') ),
            expect( ch1.sourceLine ).named( "lookAhead[1] line" ).toBe( anInteger.withValue(1) ),
            expect( ch1.sourceColumn ).named( "lookAhead[1] column" ).toBe( anInteger.withValue(2) ),
            expect( ch2.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('2') ),
            expect( ch2.sourceLine ).named( "lookAhead[2] line" ).toBe( anInteger.withValue(1) ),
            expect( ch2.sourceColumn ).named( "lookAhead[2] column" ).toBe( anInteger.withValue(3) ),
            expect( ch3.character ).named( "lookAhead[3]" ).toBe( aCharacter.withValue('3') ),
            expect( ch3.sourceLine ).named( "lookAhead[3] line" ).toBe( anInteger.withValue(1) ),
            expect( ch3.sourceColumn ).named( "lookAhead[3] column" ).toBe( anInteger.withValue(4) ),
            expect( ch2a.character ).named( "lookAhead[2a]" ).toBe( aCharacter.withValue('2') ),
            expect( ch2a.sourceLine ).named( "lookAhead[2a] line" ).toBe( anInteger.withValue(1) ),
            expect( ch2a.sourceColumn ).named( "lookAhead[2a] column" ).toBe( anInteger.withValue(3) ),
            expect( ch2a.sourceName ).named( "lookAhead[2a] source name" ).toBe( aString.withValue("Example") ),
            expect( ch3a.character ).named( "lookAhead[3a]" ).toBe( aCharacter.withValue('3') ),
            expect( ch3a.sourceLine ).named( "lookAhead[3a] line" ).toBe( anInteger.withValue(1) ),
            expect( ch3a.sourceColumn ).named( "lookAhead[3a] column" ).toBe( anInteger.withValue(4) ),
            expect( ch4a.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('\n') ),
            expect( ch4a.sourceLine ).named( "lookAhead[4a] line" ).toBe( anInteger.withValue(2) ),
            expect( ch4a.sourceColumn ).named( "lookAhead[4a] column" ).toBe( anInteger.withValue(1) ),
            expect( ch5a.character ).named( "lookAhead[5] line" ).toBe( aCharacter.withValue('5') ),
            expect( ch5a.sourceLine ).named( "lookAhead[5a] line" ).toBe( anInteger.withValue(2) ),
            expect( ch5a.sourceColumn ).named( "lookAhead[5a] column" ).toBe( anInteger.withValue(2) )
        );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testTypicalUsage
    };

}
