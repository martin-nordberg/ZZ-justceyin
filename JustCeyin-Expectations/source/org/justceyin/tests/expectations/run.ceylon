
import ceylon.file { 
    current, 
    Nil 
}
import org.justceyin.tests.expectations.constraints { 
    runConstraintTests
}
import org.justceyin.tests.expectations.constraints.providers { 
    runConstraintProviderTests 
}

doc "Run the self tests of module `org.justceyin.expectations`."
void run() {
    
    // TBD: output log name should come from command argument (not available in ANT ceylon-run task as far as I can tell)

    // create the output folder if needed
    value logPath = current.childPath( "logs" );
    if ( is Nil logFolder=logPath.resource ) {
        print( "Creating log folder" );
        logFolder.createDirectory();
    }
    else {
        print( "log folder exists" );
    }
    
    // set up the output log
    value log = TestResultLog( logPath.childPath("expectations-test.log") );
    
    try /*( log )*/ {
        log.open();

        log.print( "Cey what you mean ..." );
    
        runConstraintProviderTests( log );
        runConstraintTests( log );
    
        log.print( "All tests completed successfully." );
        print( "All tests completed successfully." );
    }
    finally {
        log.close( null );
    }
}
