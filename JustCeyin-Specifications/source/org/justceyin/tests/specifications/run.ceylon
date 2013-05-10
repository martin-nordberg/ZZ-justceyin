
import ceylon.file { 
    current 
}

doc "Run the self tests of module `org.justceyin.specifications`."
void run() {

    // TBD: output log name should come from command argument (not available in ANT ceylon-run task as far as I can tell)
    value log = TestResultLog( current.childPath("logs/specifications-test.log") );
    
    try /*( log )*/ {
        log.open();
        
        log.print( "Cey what you mean ..." );
    
        runSpecificationTests( log );
    
        log.print( "All tests completed successfully." );
        print( "All tests completed successfully." );
    }
    finally {
        log.close( null );
    }
}
