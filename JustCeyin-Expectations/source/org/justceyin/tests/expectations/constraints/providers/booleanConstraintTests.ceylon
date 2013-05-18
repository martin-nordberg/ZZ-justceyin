
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aBoolean
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all Boolean constraints."
shared void runBooleanConstraintTests( TestResultLog log ) {
    
    log.ensureSuccess( expect( true ).named( "true" ).toBe( aBoolean.thatIsTrue ),
                       "Verified true to be true." );
    log.ensureFailure( expect( true ).named( "true" ).toBe( aBoolean.thatIsFalse ),
                       "Expected true to be false, but was true." );

    log.ensureSuccess( expect( false ).named( "false" ).toBe( aBoolean.thatIsFalse ),
                       "Verified false to be false." );
    log.ensureFailure( expect( false ).named( "false" ).toBe( aBoolean.thatIsTrue ),
                       "Expected false to be true, but was false." );
}
