
import ceylon.file { 
    Path, 
    Writer
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.foundations.files {
    createFileWriter
}

"Utility class for writing out test results."
shared class TestResultLog( Path outputPath )
    satisfies Closeable {

    "The writer for the output of this log."    
    Writer writer = createFileWriter( outputPath );
    
    "Closes the log."
    shared actual void close( Exception? e ) {
        this.writer.close( e );
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
        this.writer.open();
    }

    "Prints a line of output."
    shared void print( String output ) {
        writer.writeLine( output );
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