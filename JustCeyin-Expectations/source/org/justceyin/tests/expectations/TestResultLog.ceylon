
import ceylon.language {
    printStdOut = print
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}

"Utility class for writing out test results."
shared class TestResultLog( )
    satisfies Closeable {
    
    "Closes the log."
    shared actual void close( Exception? e ) {
        
    }
    
    "Ensures that a given function throws an assertion exception."
    shared void ensureAssertion( void doSomething(), String message ) {
        try {
            doSomething();
            assert( false );
        }
        catch ( AssertionException e ) {
            assert( e.message == message );
        }
    }

    "Checks that a constraint checking result is failure."
    shared void ensureFailure( ConstraintCheckResult result, String? expectedMessage = null ) {
        
        try {
            assert ( !result.isSuccess );
        
            if ( exists expectedMessage ) {
                assert ( expectedMessage == result.message );
            }
    
            this.print( correct( result.message ) );
        }
        catch ( AssertionException e ) {
            this.print( incorrect( result.message, expectedMessage else "" ) );
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
    
            this.print( correct( result.message ) );
        }
        catch ( AssertionException e ) {
            this.print( incorrect( result.message, expectedMessage else "" ) );
            throw e;
        }
    
    }

    "Opens the log."
    shared actual void open() {
        
    }

    "Prints a line of output."
    shared void print( String output ) {
        printStdOut( output );
    }
    
    "Modifies the message from a constraint check result to indent and prepend 'Correct: '."
    String correct( String message ) {
        return "  Correct: ``message``";
    }
    
    "Modifies the message from a constraint check result to indent and prepend 'Incorrect: '."
    String incorrect( String message, String expectedMessage ) {
        return "  Incorrect: ``message``\r\n         Vs: ``expectedMessage``";
    }
    
}