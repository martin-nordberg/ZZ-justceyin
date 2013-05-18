
import org.justceyin.expectations {
	expect
}
import org.justceyin.expectations.constraints.providers { 
    anInteger
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all integer constraints."
shared void runIntegerConstraintTests( TestResultLog log ) {
    Integer zero = 0;
    Integer one = 1;
    Integer minus_one = -1;
    Integer? null_int = null;
    
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.withValue( 0 ) ),
                       "Verified zero to be equal to 0." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.withValue( 1 ) ),
                       "Expected zero to be equal to 1, but was 0." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.lessThan( 1 ) ),
                       "Verified zero to be less than 1." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.lessThanOrEqualTo( 0 ) ),
                       "Verified zero to be less than or equal to 0." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.greaterThan( 0 ) ),
                       "Expected zero to be greater than 0, but was 0." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.greaterThanOrEqualTo( 1 ) ),
                       "Expected zero to be greater than or equal to 1, but was 0." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.thatIsNegative ),
                       "Expected zero to be negative, but was 0." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.thatIsNotNegative ),
                       "Verified zero to be not negative." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.thatIsPositive ),
                       "Expected zero to be positive, but was 0." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.thatIsNotPositive ),
                       "Verified zero to be not positive." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.thatIsZero ),
                       "Verified zero to be zero." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.thatIsNonzero ),
                       "Expected zero to be nonzero, but was 0." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.thatIsUnit ),
                       "Expected zero to be unit, but was 0." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.thatIsNotUnit ),
                       "Verified zero to be not unit." );

    log.ensureSuccess( expect( one ).toBe( anInteger.withValue( 1 ) ),
                       "Verified value to be equal to 1." );
    log.ensureFailure( expect( one ).toBe( anInteger.withValue( 2 ) ),
                       "Expected value to be equal to 2, but was 1." );
    log.ensureFailure( expect( one ).toBe( anInteger.thatIsNegative ),
                       "Expected value to be negative, but was 1." );
    log.ensureSuccess( expect( one ).toBe( anInteger.thatIsNotNegative ),
                       "Verified value to be not negative." );
    log.ensureSuccess( expect( one ).toBe( anInteger.thatIsPositive ),
                       "Verified value to be positive." );
    log.ensureFailure( expect( one ).toBe( anInteger.thatIsNotPositive ),
                       "Expected value to be not positive, but was 1." );
    log.ensureFailure( expect( one ).toBe( anInteger.thatIsZero ),
                       "Expected value to be zero, but was 1." );
    log.ensureSuccess( expect( one ).toBe( anInteger.thatIsNonzero ),
                       "Verified value to be nonzero." );
    log.ensureSuccess( expect( one ).toBe( anInteger.thatIsUnit ),
                       "Verified value to be unit." );
    log.ensureFailure( expect( one ).toBe( anInteger.thatIsNotUnit ),
                       "Expected value to be not unit, but was 1." );

    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( anInteger.withValue( -1 ) ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( anInteger.withValue( -2 ) ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( anInteger.thatIsNegative ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( anInteger.thatIsNotNegative ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( anInteger.thatIsPositive ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( anInteger.thatIsNotPositive ) );
    
    log.ensureSuccess( expect( null_int ).named( "null" ).toNotExist() );
    log.ensureFailure( expect( null_int ).named( "null" ).toBe( anInteger.withValue( 3 ) ) );
    log.ensureSuccess( expect( null_int ).named( "null" ).toOptionallyBe( anInteger.withValue( 3 ) ) );

}
