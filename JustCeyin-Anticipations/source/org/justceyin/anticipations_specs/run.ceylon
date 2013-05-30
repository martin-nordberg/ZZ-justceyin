
import org.justceyin.specifications { 
    Specification 
}
import org.justceyin.specifications.reporters { 
    SimpleTextReporter 
}
import org.justceyin.specifications.runners { 
    SimpleSpecificationRunner 
}


"Runs a specification; prints the report; ensures a successful outcome."
void runSpecification( Specification specification ) {
    value runResult1 = SimpleSpecificationRunner( specification ).run();
    print( SimpleTextReporter().report( runResult1 ) );
    assert( runResult1.isSuccess );
}

doc "Run the module `org.justceyin.anticipations_specs`."
void run() {

    runSpecification( FutureSpecification() );
    
}