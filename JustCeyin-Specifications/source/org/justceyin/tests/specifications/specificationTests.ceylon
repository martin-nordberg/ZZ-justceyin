
import org.justceyin.specifications { 
    CompositeSpecification, 
    Specification 
}
import org.justceyin.specifications.examples { 
    IntegerStackDeclarativeSpecification,
    IntegerStackImperativeSpecification, 
    IntegerStackMixedSpecification
}
import org.justceyin.specifications.reporters { 
    SimpleTextReporter 
}
import org.justceyin.specifications.runners { 
    SimpleSpecificationRunner 
}

"Runs a specification; prints the report; ensures a successful outcome."
void runSpecificationTest( TestResultLog log, Specification specification ) {
    value runResult1 = SimpleSpecificationRunner( specification ).run();
    log.print( SimpleTextReporter().report( runResult1 ) );
    assert( runResult1.isSuccess );
}

"Exercises typical specifications."
shared void runSpecificationTests( TestResultLog log ) {
    log.print( "" );
    log.print( "Integer Stack Declarative Specification:" );
    log.print( "----------------------------------------" );
    runSpecificationTest( log, IntegerStackDeclarativeSpecification() );

    log.print( "" );
    log.print( "Integer Stack Imperative Specification:" );
    log.print( "---------------------------------------" );
    runSpecificationTest( log, IntegerStackImperativeSpecification() );

    log.print( "" );
    log.print( "Integer Stack Mixed Specification:" );
    log.print( "----------------------------------" );
    runSpecificationTest( log, IntegerStackMixedSpecification() );

    log.print( "" );
    log.print( "Integer Stack Composite Specification:" );
    log.print( "--------------------------------------" );
    value suite = CompositeSpecification( {IntegerStackDeclarativeSpecification(),IntegerStackImperativeSpecification()} );
    runSpecificationTest( log, suite );
}
