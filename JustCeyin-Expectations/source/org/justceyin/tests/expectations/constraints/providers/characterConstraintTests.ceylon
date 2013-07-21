
import org.justceyin.expectations {
	expect
}

import org.justceyin.expectations.constraints.providers { 
    aCharacter
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all character constraints."
shared void runCharacterConstraintTests( TestResultLog log ) {
    Character a = 'a';
    Character aa = 'A';
    
    log.ensureSuccess( expect( a ).named( "a" ).toBe( aCharacter.withValue( 'a' ) ) );
    log.ensureSuccess( expect( a ).named( "a" ).toBe( aCharacter.thatIsLowerCase ) );
    log.ensureSuccess( expect( aa ).named( "A" ).toBe( aCharacter.thatIsUpperCase ) );

}
