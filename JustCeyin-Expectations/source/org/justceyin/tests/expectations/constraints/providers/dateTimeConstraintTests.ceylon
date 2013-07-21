
import ceylon.time {
    DateTime,
    rightNow = now
}
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aDateTime
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all DateTime constraints."
shared void runDateTimeConstraintTests( TestResultLog log ) {
    
    DateTime now = rightNow().dateTime();
    DateTime justPast = now.minusMilliseconds( 1 );
    DateTime yesterday = now.minusDays(1);
    DateTime tomorrow = now.plusDays(1);
    
    log.ensureSuccess( expect( now ).named( "today" ).toBe( aDateTime.withValue( now ) ),
                       "Verified today to be equal to ``now``." );
    
    log.ensureFailure( expect( now ).named( "today" ).toBe( aDateTime.beforeToday ),
                       "Expected today to be before today, but was ``now``." );
    log.ensureSuccess( expect( now ).named( "today" ).toBe( aDateTime.onOrBeforeToday ),
                       "Verified today to be on or before today." );
    log.ensureSuccess( expect( now ).named( "today" ).toBe( aDateTime.today ),
                       "Verified today to be today." );
    log.ensureSuccess( expect( now ).named( "today" ).toBe( aDateTime.onOrAfterToday ),
                       "Verified today to be on or after today." );
    log.ensureFailure( expect( now ).named( "today" ).toBe( aDateTime.afterToday ),
                       "Expected today to be after today, but was ``now``." );

    log.ensureFailure( expect( justPast ).named( "just past" ).toBe( aDateTime.beforeToday ),
                       "Expected just past to be before today, but was ``justPast``." );
    log.ensureSuccess( expect( justPast ).named( "just past" ).toBe( aDateTime.beforeNow ),
                       "Verified just past to be before now." );
    log.ensureSuccess( expect( justPast ).named( "just past" ).toBe( aDateTime.onOrBeforeToday ),
                       "Verified just past to be on or before today." );
    log.ensureSuccess( expect( justPast ).named( "just past" ).toBe( aDateTime.today ),
                       "Verified just past to be today." );
    log.ensureSuccess( expect( justPast ).named( "just past" ).toBe( aDateTime.onOrAfterToday ),
                       "Verified just past to be on or after today." );
    log.ensureFailure( expect( justPast ).named( "just past" ).toBe( aDateTime.afterNow ),
                       "Expected just past to be after now, but was ``justPast``." );
    log.ensureFailure( expect( justPast ).named( "just past" ).toBe( aDateTime.afterToday ),
                       "Expected just past to be after today, but was ``justPast``." );

    log.ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.beforeNow ),
                       "Verified yesterday to be before now." );
    log.ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.beforeToday ),
                       "Verified yesterday to be before today." );
    log.ensureSuccess( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.onOrBeforeToday ),
                       "Verified yesterday to be on or before today." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.today ),
                       "Expected yesterday to be today, but was ``yesterday``." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.afterNow ),
                       "Expected yesterday to be after now, but was ``yesterday``." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.afterToday ),
                       "Expected yesterday to be after today, but was ``yesterday``." );
    log.ensureFailure( expect( yesterday ).named( "yesterday" ).toBe( aDateTime.onOrAfterToday ),
                       "Expected yesterday to be on or after today, but was ``yesterday``." );

    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.beforeNow ),
                       "Expected tomorrow to be before now, but was ``tomorrow``." );
    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.beforeToday ),
                       "Expected tomorrow to be before today, but was ``tomorrow``." );
    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.onOrBeforeToday ),
                       "Expected tomorrow to be on or before today, but was ``tomorrow``." );
    log.ensureFailure( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.today ),
                       "Expected tomorrow to be today, but was ``tomorrow``." );
    log.ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.afterNow ),
                       "Verified tomorrow to be after now." );
    log.ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.afterToday ),
                       "Verified tomorrow to be after today." );
    log.ensureSuccess( expect( tomorrow ).named( "tomorrow" ).toBe( aDateTime.onOrAfterToday ),
                       "Verified tomorrow to be on or after today." );


}
