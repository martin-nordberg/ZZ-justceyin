
import org.justceyin.expectations {
    expect
}

import org.justceyin.expectations.constraints.providers { 
    anInteger
}

"Exercises AND and OR constraints."
shared void runAndOrConstraintTests() {
    Integer zero = 0;
    Integer ten = 10;
    
    ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.withValue( 0 ).or( anInteger.withValue( 10 )) ),
                   "Verified zero to be equal to 0." );
    ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.withValue( 10 ).or( anInteger.withValue( 0 )) ),
                   "Verified zero to be equal to 0." );
    ensureSuccess( expect( ten ).named( "ten" ).toBe( anInteger.withValue( 0 ).or( anInteger.withValue( 10 )) ),
                   "Verified ten to be equal to 10." );
    ensureSuccess( expect( ten ).named( "ten" ).toBe( anInteger.withValue( 10 ).or( anInteger.withValue( 0 )) ),
                   "Verified ten to be equal to 10." );

    ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.lessThan( 1 ).or( anInteger.greaterThan( 9 )) ),
                   "Verified zero to be less than 1." );
    ensureSuccess( expect( ten ).named( "ten" ).toBe( anInteger.lessThan( 1 ).or( anInteger.greaterThan( 9 )) ),
                   "Verified ten to be greater than 9." );

    ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.lessThan( -1 ).or( anInteger.greaterThan( 1 )) ),
                   "Expected zero to be less than -1, but was 0. -OR- Expected zero to be greater than 1, but was 0." );

    ensureSuccess( expect( zero ).named( "zero" ).toBe( anInteger.greaterThan( -1 ).and( anInteger.lessThan( 1 )) ),
                   "Verified zero to be greater than -1. -AND- Verified zero to be less than 1." );
    ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.greaterThan( 1 ).and( anInteger.lessThan( 1 )) ),
                   "Expected zero to be greater than 1, but was 0." );
    ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.greaterThan( 0 ).and( anInteger.lessThan( 0 )) ),
                   "Expected zero to be greater than 0, but was 0." );
    ensureFailure( expect( zero ).named( "zero" ).toBe( anInteger.greaterThan( -1 ).and( anInteger.lessThan( 0 )) ),
                   "Expected zero to be less than 0, but was 0." );
}
