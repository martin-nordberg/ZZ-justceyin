
import org.justceyin.tests.expectations.constraints { 
    runConstraintTests
}
import org.justceyin.tests.expectations.constraints.providers { 
    runConstraintProviderTests 
}

doc "Run the self tests of module `org.justceyin.expectations`."
void run() {
    
    value log = TestResultLog();
    
    try /*( log )*/ {
        log.open();

        log.print( "Cey what you mean ...");
    
        runConstraintProviderTests( log );
        runConstraintTests( log );
    
        log.print( "All tests completed successfully.");
    }
    finally {
        log.close( null );
    }
}
