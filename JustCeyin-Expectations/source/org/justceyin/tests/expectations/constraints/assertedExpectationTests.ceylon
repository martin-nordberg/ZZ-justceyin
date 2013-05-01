
import org.justceyin.expectations { 
    constrain 
}

import org.justceyin.expectations.constraints.providers { 
    anInteger 
}

"Ensures that a given function throws an assertion exception."
void ensureAssertion( void doSomething(), String message ) {
    try {
        doSomething();
        assert( false );
    }
    catch ( AssertionException e ) {
        assert( e.message == message );
    }
}

"Exercises the AssertedExpectation adapter."
shared void runAssertedExpectationTests() {
    Integer zero = 0;

    constrain( zero ).named( "zero" ).toBe( anInteger.withValue( 0 ) );

    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.withValue( 1 ) ),
                     "Expected zero to be equal to 1, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.lessThan( 1 ) );
    constrain( zero ).named( "zero" ).toBe( anInteger.lessThanOrEqualTo( 0 ) );
    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.greaterThan( 0 ) ),
                     "Expected zero to be greater than 0, but was 0." );
    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.greaterThanOrEqualTo( 1 ) ),
                     "Expected zero to be greater than or equal to 1, but was 0." );
    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNegative ),
                     "Expected zero to be negative, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNotNegative );
    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsPositive ),
                     "Expected zero to be positive, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNotPositive );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsZero );
    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNonzero ),
                     "Expected zero to be nonzero, but was 0." );
    ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsUnit ),
                     "Expected zero to be unit, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNotUnit );
    
}
