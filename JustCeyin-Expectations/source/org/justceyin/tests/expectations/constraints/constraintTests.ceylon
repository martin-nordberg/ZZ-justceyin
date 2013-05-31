
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all constraints."
shared void runConstraintTests( TestResultLog log ) {

    log.writeLine( "" );
    log.writeLine( "Constraint Tests:" );
    log.writeLine( "-----------------" );

    log.writeLine( " And/Or Constraints:" );
    runAndOrConstraintTests( log );
    
    log.writeLine( " Asserted Expectation Tests:" );
    runAssertedExpectationTests( log );
    log.writeLine( "  (Assertion exceptions thrown as expected.)" );

}

