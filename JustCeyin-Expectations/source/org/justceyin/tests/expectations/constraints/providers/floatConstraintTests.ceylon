
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aFloat
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all floating point constraints."
shared void runFloatConstraintTests( TestResultLog log ) {
    Float zero = 0.0;
    Float minus_zero = -0.0;
    Float one = 1.0;
    Float minus_one = -1.0;
    
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.withValue( 0.0 ) ),
                       "Verified zero to be equal to 0.0." );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.withValue( 1.0 ) ),
                       "Expected zero to be equal to 1.0, but was 0.0." );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.lessThan( 1.0 ) ) );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.lessThanOrEqualTo( 0.0 ) ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.greaterThan( 0.0 ) ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.greaterThanOrEqualTo( 1.0 ) ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNegative ) );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNotNegative ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsPositive ) );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNotPositive ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsStrictlyNegative ) );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsStrictlyPositive ) );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsFinite ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsInfinite ) );
    log.ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsUndefined ) );
    log.ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNotUndefined ) );

    log.ensureSuccess( expect( minus_zero ).named( "minus_zero" ).toBe( aFloat.thatIsStrictlyNegative ) );
    log.ensureFailure( expect( minus_zero ).named( "minus_zero" ).toBe( aFloat.thatIsStrictlyPositive ) );

    log.ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.withValue( 1.0 ) ) );
    log.ensureFailure( expect( one ).named( "one" ).toBe( aFloat.withValue( 2.0 ) ) );
    log.ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsNegative ) );
    log.ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsNotNegative ) );
    log.ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsPositive ) );
    log.ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsNotPositive ) );
    log.ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsStrictlyNegative ) );
    log.ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsStrictlyPositive ) );
    log.ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsFinite ) );
    log.ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsInfinite ) );
    log.ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsUndefined ) );
    log.ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsNotUndefined ) );

    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.withValue( -1.0 ) ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.withValue( -2.0 ) ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNegative ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNotNegative ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsPositive ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNotPositive ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsStrictlyNegative ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsStrictlyPositive ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsFinite ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsInfinite ) );
    log.ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsUndefined ) );
    log.ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNotUndefined ) );

    log.ensureFailure( expect( infinity ).named( "infinity" ).toBe( aFloat.thatIsFinite ) );
    log.ensureSuccess( expect( infinity ).named( "infinity" ).toBe( aFloat.thatIsInfinite ) );
}
