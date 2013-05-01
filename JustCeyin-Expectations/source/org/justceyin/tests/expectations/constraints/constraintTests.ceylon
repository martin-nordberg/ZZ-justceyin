
import org.justceyin.expectations.constraints { 
	ConstraintCheckResult
}

"Modifies the message from a constraint check result to indent and prepend 'Correct: '."
String correct( String message ) {
    return "  Correct: ``message``";
}

"Modifies the message from a constraint check result to indent and prepend 'Incorrect: '."
String incorrect( String message, String expectedMessage ) {
    return "  Incorrect: ``message``\r\n         Vs: ``expectedMessage``";
}

"Checks that a constraint checking result is failure."
shared void ensureFailure( ConstraintCheckResult result, String? expectedMessage = null ) {
	
    try {
		assert ( !result.isSuccess );
	
	    if ( exists expectedMessage ) {
	        assert ( expectedMessage == result.message );
	    }

        print( correct( result.message ) );
	}
    catch ( AssertionException e ) {
        print( incorrect( result.message, expectedMessage else "" ) );
        throw e;
    }

}

"Checks that a constraint checking result is success."
shared void ensureSuccess( ConstraintCheckResult result, String? expectedMessage = null ) {
	
    try {
        assert ( result.isSuccess );
    
        if ( exists expectedMessage ) {
            assert ( expectedMessage == result.message );
        }

        print( correct( result.message ) );
    }
    catch ( AssertionException e ) {
        print( incorrect( result.message, expectedMessage else "" ) );
        throw e;
    }

}

"Exercises all constraints."
shared void runConstraintTests() {

    print( "" );
    print( "Constraint Tests:" );
    print( "-----------------" );

    print( " And/Or Constraints:" );
    runAndOrConstraintTests();
    
    print( " Asserted Expectation Tests:" );
    runAssertedExpectationTests();
    print( "  (Assertion exceptions thrown as expected.)" );

}

