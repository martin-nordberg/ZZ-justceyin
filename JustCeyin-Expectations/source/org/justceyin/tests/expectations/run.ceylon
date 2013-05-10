
import ceylon.file { 
    current 
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
    value log = TestResultLog( current.childPath("logs/expectations-test.log") );
    
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
