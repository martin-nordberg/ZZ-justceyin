
import ceylon.file { 
    current,
    Nil
}

doc "Run the self tests of module `org.justceyin.specifications`."
void run() {

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
    value log = TestResultLog( logPath.childPath("specifications-test.log") );
    
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
