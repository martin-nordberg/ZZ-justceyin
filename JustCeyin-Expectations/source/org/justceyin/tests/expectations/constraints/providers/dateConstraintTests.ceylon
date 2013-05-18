
import ceylon.time {
    Date, 
    todaysDate = today
}
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aDate
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all Date constraints."
shared void runDateConstraintTests( TestResultLog log ) {
    
    Date today = todaysDate();
    Date yesterday = today.minusDays(1);
    Date tomorrow = today.plusDays(1);
    
    log.ensureSuccess( expect( today ).named( "today" ).toBe( aDate.withValue( todaysDate() ) ),
                       "Verified today to be equal to ``today``." );
    
    log.ensureFailure( expect( today ).named( "today" ).toBe( aDate.beforeToday ),
                       "Expected today to be before today, but was ``today``." );
    log.ensureSuccess( expect( today ).named( "today" ).toBe( aDate.onOrBeforeToday ),
                       "Verified today to be on or before today." );
    log.ensureSuccess( expect( today ).named( "today" ).toBe( aDate.today ),
                       "Verified today to be today." );
    log.ensureSuccess( expect( today ).named( "today" ).toBe( aDate.onOrAfterToday ),
                       "Verified today to be on or after today." );
    log.ensureFailure( expect( today ).named( "today" ).toBe( aDate.afterToday ),
                       "Expected today to be after today, but was ``today``." );

    log.ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDate.beforeToday ),
                       "Verified yesterday to be before today." );
    log.ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDate.onOrBeforeToday ),
                       "Verified yesterday to be on or before today." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDate.today ),
                       "Expected yesterday to be today, but was ``yesterday``." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDate.afterToday ),
                       "Expected yesterday to be after today, but was ``yesterday``." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDate.onOrAfterToday ),
                       "Expected yesterday to be on or after today, but was ``yesterday``." );

    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.beforeToday ),
                       "Expected tomorrow to be before today, but was ``tomorrow``." );
    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.onOrBeforeToday ),
                       "Expected tomorrow to be on or before today, but was ``tomorrow``." );
    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.today ),
                       "Expected tomorrow to be today, but was ``tomorrow``." );
    log.ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.afterToday ),
                       "Verified tomorrow to be after today." );
    log.ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDate.onOrAfterToday ),
                       "Verified tomorrow to be on or after today." );


}
