
import org.justceyin.expectations {
    expect
}
import org.justceyin.expectations.constraints.providers { 
    aBoolean
}
import org.justceyin.tests.expectations.constraints { 
    ensureFailure, 
    ensureSuccess 
}

"Exercises all Boolean constraints."
shared void runBooleanConstraintTests() {
    
    ensureSuccess( expect( true ).named( "true" ).toBe( aBoolean.thatIsTrue ),
                   "Verified true to be true." );
    ensureFailure( expect( true ).named( "true" ).toBe( aBoolean.thatIsFalse ),
                   "Expected true to be false, but was true." );

    ensureSuccess( expect( false ).named( "false" ).toBe( aBoolean.thatIsFalse ),
                   "Verified false to be false." );
    ensureFailure( expect( false ).named( "false" ).toBe( aBoolean.thatIsTrue ),
                   "Expected false to be true, but was false." );
}
