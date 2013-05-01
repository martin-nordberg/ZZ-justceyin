
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aFloat
}
import org.justceyin.tests.expectations.constraints { 
    ensureFailure, 
    ensureSuccess 
}

"Exercises all floating point constraints."
shared void runFloatConstraintTests() {
    Float zero = 0.0;
    Float minus_zero = -0.0;
    Float one = 1.0;
    Float minus_one = -1.0;
    
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.withValue( 0.0 ) ),
                   "Verified zero to be equal to 0.0." );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.withValue( 1.0 ) ),
                   "Expected zero to be equal to 1.0, but was 0.0." );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.lessThan( 1.0 ) ) );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.lessThanOrEqualTo( 0.0 ) ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.greaterThan( 0.0 ) ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.greaterThanOrEqualTo( 1.0 ) ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNegative ) );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNotNegative ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsPositive ) );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNotPositive ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsStrictlyNegative ) );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsStrictlyPositive ) );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsFinite ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsInfinite ) );
    ensureFailure( expect( zero ).named( "zero" ).toBe( aFloat.thatIsUndefined ) );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( aFloat.thatIsNotUndefined ) );

    ensureSuccess( expect( minus_zero ).named( "minus_zero" ).toBe( aFloat.thatIsStrictlyNegative ) );
    ensureFailure( expect( minus_zero ).named( "minus_zero" ).toBe( aFloat.thatIsStrictlyPositive ) );

    ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.withValue( 1.0 ) ) );
    ensureFailure( expect( one ).named( "one" ).toBe( aFloat.withValue( 2.0 ) ) );
    ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsNegative ) );
    ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsNotNegative ) );
    ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsPositive ) );
    ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsNotPositive ) );
    ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsStrictlyNegative ) );
    ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsStrictlyPositive ) );
    ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsFinite ) );
    ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsInfinite ) );
    ensureFailure( expect( one ).named( "one" ).toBe( aFloat.thatIsUndefined ) );
    ensureSuccess( expect( one ).named( "one" ).toBe( aFloat.thatIsNotUndefined ) );

    ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.withValue( -1.0 ) ) );
    ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.withValue( -2.0 ) ) );
    ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNegative ) );
    ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNotNegative ) );
    ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsPositive ) );
    ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNotPositive ) );
    ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsStrictlyNegative ) );
    ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsStrictlyPositive ) );
    ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsFinite ) );
    ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsInfinite ) );
    ensureFailure( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsUndefined ) );
    ensureSuccess( expect( minus_one ).named( "minus_one" ).toBe( aFloat.thatIsNotUndefined ) );

    ensureFailure( expect( infinity ).named( "infinity" ).toBe( aFloat.thatIsFinite ) );
    ensureSuccess( expect( infinity ).named( "infinity" ).toBe( aFloat.thatIsInfinite ) );
}
