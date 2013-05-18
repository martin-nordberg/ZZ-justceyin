
import org.justceyin.expectations { 
    constrain 
}

import org.justceyin.expectations.constraints.providers { 
    anInteger 
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises the AssertedExpectation adapter."
shared void runAssertedExpectationTests( TestResultLog log ) {
    Integer zero = 0;

    constrain( zero ).named( "zero" ).toBe( anInteger.withValue( 0 ) );

    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.withValue( 1 ) ),
                         "Expected zero to be equal to 1, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.lessThan( 1 ) );
    constrain( zero ).named( "zero" ).toBe( anInteger.lessThanOrEqualTo( 0 ) );
    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.greaterThan( 0 ) ),
                         "Expected zero to be greater than 0, but was 0." );
    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.greaterThanOrEqualTo( 1 ) ),
                         "Expected zero to be greater than or equal to 1, but was 0." );
    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNegative ),
                         "Expected zero to be negative, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNotNegative );
    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsPositive ),
                         "Expected zero to be positive, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNotPositive );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsZero );
    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNonzero ),
                         "Expected zero to be nonzero, but was 0." );
    log.ensureAssertion( () => constrain( zero ).named( "zero" ).toBe( anInteger.thatIsUnit ),
                         "Expected zero to be unit, but was 0." );
    constrain( zero ).named( "zero" ).toBe( anInteger.thatIsNotUnit );
    
}
