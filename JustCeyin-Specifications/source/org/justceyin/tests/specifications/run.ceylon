
doc "Run the self tests of module `org.justceyin.specifications`."
void run() {

    value log = TestResultLog();
    
    try /*( log )*/ {
        log.open();
        
        log.print( "Cey what you mean ...");
    
        runSpecificationTests( log );
    
        log.print( "All tests completed successfully.");
    }
    finally {
        log.close( null );
    }
}
