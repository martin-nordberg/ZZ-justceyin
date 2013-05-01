
import org.justceyin.expectations.constraints { 
	ConstraintCheckResult
}
import org.justceyin.specifications.runners { 
    SimpleSpecificationRunner 
}
import org.justceyin.specifications.examples { 
    IntegerStackDeclarativeSpecification,
    IntegerStackImperativeSpecification, 
    IntegerStackMixedSpecification
}
import org.justceyin.specifications.reporters { 
    SimpleTextReporter 
}

"Modifies the message from a constraint check result to indent and prepend 'Correctly '."
String correctly( String message ) {
    return "  Correctly " + message.span(0,0).lowercased + message.span(1,1000);
}

"Modifies the message from a constraint check result to indent and prepend 'Incorrectly '."
String incorrectly( String message ) {
    return "  Incorrectly " + message.span(0,0).lowercased + message.span(1,1000);
}

"Checks that a constraint checking result is failure."
shared void ensureFailure( ConstraintCheckResult result, String? expectedMessage = null ) {
	
    try {
		assert ( !result.isSuccess );
	
	    if ( exists expectedMessage ) {
	        assert ( expectedMessage == result.message );
	    }

        print( correctly( result.message ) );
	}
    catch ( AssertionException e ) {
        print( incorrectly( result.message ) );
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

        print( correctly( result.message ) );
    }
    catch ( AssertionException e ) {
        print( incorrectly( result.message ) );
        throw e;
    }

}

"Exercises typical specifications."
shared void runSpecificationTests() {
    print( "" );
    print( "Integer Stack Declarative Specification:" );
    print( "----------------------------------------" );
    value runResult1 = SimpleSpecificationRunner( IntegerStackDeclarativeSpecification() ).run();
    print( SimpleTextReporter().report( runResult1 ) );
    assert( runResult1.isSuccess );

    print( "" );
    print( "Integer Stack Imperative Specification:" );
    print( "---------------------------------------" );
    value runResult2 = SimpleSpecificationRunner( IntegerStackImperativeSpecification() ).run();
    print( SimpleTextReporter().report( runResult2 ) );
    assert( runResult2.isSuccess );

    print( "" );
    print( "Integer Stack Mixed Specification:" );
    print( "----------------------------------" );
    value runResult3 = SimpleSpecificationRunner( IntegerStackMixedSpecification() ).run();
    print( SimpleTextReporter().report( runResult3 ) );
    assert( runResult3.isSuccess );
}
