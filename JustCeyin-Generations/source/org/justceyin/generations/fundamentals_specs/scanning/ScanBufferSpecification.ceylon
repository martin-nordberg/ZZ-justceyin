
import org.justceyin.specifications {
    ImperativeSpecification
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.expectations.constraints.providers { 
    aCharacter 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.generations.fundamentals.scanning { 
    ScanBuffer 
}

"Specification exercises a Lexer implementation."
by "Martin E. Nordberg III"
shared class ScanBufferSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "ScanBuffer Specification";

    "A scanner reads character one at a time in order."
    void testLookAheadAndAdvance( void outcomes( ConstraintCheckResult* results ) ) {
        String input = "0123456789";
        
        ScanBuffer scanner = ScanBuffer( 4, 2, input.iterator() );
        
        scanner.initialize();
        
        value ch0 = scanner.lookAhead(0);
        value ch1 = scanner.lookAhead(1);
        value ch2 = scanner.lookAhead(2);
        value ch3 = scanner.lookAhead(3);
        
        outcomes( 
            expect( ch0.character ).named( "lookAhead[0]" ).toBe( aCharacter.withValue('0') ),
            expect( ch1.character ).named( "lookAhead[1]" ).toBe( aCharacter.withValue('1') ),
            expect( ch2.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('2') ),
            expect( ch3.character ).named( "lookAhead[3]" ).toBe( aCharacter.withValue('3') )
        );

        scanner.advance( 2 );
        
        value ch2a = scanner.lookAhead(0);
        value ch3a = scanner.lookAhead(1);
        value ch4a = scanner.lookAhead(2);
        value ch5a = scanner.lookAhead(3);
        
        outcomes( 
            expect( ch0.character ).named( "lookAhead[0]" ).toBe( aCharacter.withValue('0') ),
            expect( ch1.character ).named( "lookAhead[1]" ).toBe( aCharacter.withValue('1') ),
            expect( ch2.character ).named( "lookAhead[2]" ).toBe( aCharacter.withValue('2') ),
            expect( ch3.character ).named( "lookAhead[3]" ).toBe( aCharacter.withValue('3') ),
            expect( ch2a.character ).named( "lookAhead[2a]" ).toBe( aCharacter.withValue('2') ),
            expect( ch3a.character ).named( "lookAhead[3a]" ).toBe( aCharacter.withValue('3') ),
            expect( ch4a.character ).named( "lookAhead[4a]" ).toBe( aCharacter.withValue('4') ),
            expect( ch5a.character ).named( "lookAhead[5a]" ).toBe( aCharacter.withValue('5') )
        );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testLookAheadAndAdvance
    };

}
