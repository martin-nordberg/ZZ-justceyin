
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all constraints."
shared void runConstraintTests( TestResultLog log ) {

    log.print( "" );
    log.print( "Constraint Tests:" );
    log.print( "-----------------" );

    log.print( " And/Or Constraints:" );
    runAndOrConstraintTests( log );
    
    log.print( " Asserted Expectation Tests:" );
    runAssertedExpectationTests( log );
    log.print( "  (Assertion exceptions thrown as expected.)" );

}

