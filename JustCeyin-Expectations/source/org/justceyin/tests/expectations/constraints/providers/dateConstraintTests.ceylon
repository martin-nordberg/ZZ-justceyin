
import ceylon.time {
    Date, 
    today
}
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aDate
}
import org.justceyin.tests.expectations.constraints { 
    ensureFailure, 
    ensureSuccess 
}

"Exercises all Date constraints."
shared void runDateConstraintTests() {
    
    Date now = today();
    Date yesterday = now.minusDays(1);
    Date tomorrow = now.plusDays(1);
    
    ensureSuccess( expect( now ).named( "today" ).toBe( aDate.withValue( today() ) ),
                   "Verified today to be equal to ``now``." );
    ensureSuccess( expect( now ).named( "today" ).toBe( aDate.onOrBeforeToday ),
                   "Verified today to be on or before today." );

    ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDate.beforeToday ),
                   "Verified yesterday to be before today." );
    ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDate.onOrBeforeToday ),
                   "Verified yesterday to be on or before today." );
    ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDate.afterToday ),
                   "Expected yesterday to be after today, but was ``yesterday``." );
    ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDate.onOrAfterToday ),
                   "Expected yesterday to be on or after today, but was ``yesterday``." );

    ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.beforeToday ),
                   "Expected tomorrow to be before today, but was ``tomorrow``." );
    ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.onOrBeforeToday ),
                   "Expected tomorrow to be on or before today, but was ``tomorrow``." );
    ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.afterToday ),
                   "Verified tomorrow to be after today." );
    ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.onOrAfterToday ),
                   "Verified tomorrow to be on or after today." );
}
