
import org.justceyin.specifications { 
    CompositeSpecification, 
    Specification 
}
import org.justceyin.specifications.examples { 
    IntegerStackDeclarativeSpecification,
    IntegerStackImperativeSpecification, 
    IntegerStackMixedSpecification
}
import org.justceyin.foundations.io { 
    TextWriter 
}
import org.justceyin.specifications.reporters { 
    SimpleTextReporter 
}
import org.justceyin.specifications.runners { 
    SimpleSpecificationRunner 
}

"Runs a specification; prints the report; ensures a successful outcome."
void runSpecificationTest( TextWriter log, Specification specification ) {
    value runResult = SimpleSpecificationRunner( specification ).run();
    log.writeLine( SimpleTextReporter().report( runResult ) );
    assert( runResult.isSuccess );
}

"Exercises typical specifications."
shared void runSpecificationTests( TextWriter log ) {
    log.writeLine( "" );
    log.writeLine( "Integer Stack Declarative Specification:" );
    log.writeLine( "----------------------------------------" );
    runSpecificationTest( log, IntegerStackDeclarativeSpecification() );

    log.writeLine( "" );
    log.writeLine( "Integer Stack Imperative Specification:" );
    log.writeLine( "---------------------------------------" );
    runSpecificationTest( log, IntegerStackImperativeSpecification() );

    log.writeLine( "" );
    log.writeLine( "Integer Stack Mixed Specification:" );
    log.writeLine( "----------------------------------" );
    runSpecificationTest( log, IntegerStackMixedSpecification() );

    log.writeLine( "" );
    log.writeLine( "Integer Stack Composite Specification:" );
    log.writeLine( "--------------------------------------" );
    value suite = CompositeSpecification( {IntegerStackDeclarativeSpecification(),IntegerStackImperativeSpecification()} );
    runSpecificationTest( log, suite );
}
