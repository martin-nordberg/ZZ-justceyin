
import ceylon.file { 
    current
}
import org.justceyin.foundations.files { 
    createDirectoryIfNeeded 
}
import org.justceyin.foundations.io { 
    FileAppender,
    TextWriter,
    TextWriterAppender
}
import org.justceyin.specifications { 
    CompositeSpecification, 
    Specification
}
import org.justceyin.specifications.reporters { 
    SimpleTextReporter 
}
import org.justceyin.specifications.runners { 
    SimpleSpecificationRunner 
}
import org.justceyin.generations.fundamentals_specs.indentation { 
    IndentingWriterSpecification 
}


"Runs a specification; prints the report; ensures a successful outcome."
void runSpecification( TextWriter log, Specification specification ) {
    value runResult = SimpleSpecificationRunner( specification ).run();
    value report = SimpleTextReporter().report( runResult );
    log.writeLine( report );
    assert( runResult.isSuccess );
}

"Run the module `org.justceyin.foundations_specs`."
void run() {

    // create the output folder if needed
    value logPath = current.childPath( "logs" );
    createDirectoryIfNeeded( logPath );
    
    // set up the output log
    TextWriter log = TextWriterAppender( FileAppender( logPath.childPath("generations-fundamentals-test.log"), false ) );
    
    try /*( log )*/ {
        log.open();

        log.writeLine( "Cey what you mean ..." );
        log.writeLine( "" );
    
        value suite = CompositeSpecification( {
                          IndentingWriterSpecification()
                      } );
        runSpecification( log, suite );
    
        log.writeLine( "All tests completed successfully." );
        print( "All tests completed successfully." );
    }
    finally {
        log.close( null );
    }
}