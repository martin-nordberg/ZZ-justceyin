
import org.justceyin.specifications { 
    CompositeSpecification 
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

"Exercises typical specifications."
shared void runSpecificationTests() {
    print( "" );
    print( "Integer Stack Declarative Specification:" );
    print( "----------------------------------------" );
    value runResult1 = SimpleSpecificationRunner( IntegerStackDeclarativeSpecification() ).run();
    print( SimpleTextReporter().report( runResult1 ) );
    assert( runResult1.isSuccess );

    print( "" );
    print( "Integer Stack Imperative Specification:" );
    print( "---------------------------------------" );
    value runResult2 = SimpleSpecificationRunner( IntegerStackImperativeSpecification() ).run();
    print( SimpleTextReporter().report( runResult2 ) );
    assert( runResult2.isSuccess );

    print( "" );
    print( "Integer Stack Mixed Specification:" );
    print( "----------------------------------" );
    value runResult3 = SimpleSpecificationRunner( IntegerStackMixedSpecification() ).run();
    print( SimpleTextReporter().report( runResult3 ) );
    assert( runResult3.isSuccess );

    print( "" );
    print( "Integer Stack Composite Specification:" );
    print( "--------------------------------------" );
    value suite = CompositeSpecification( {IntegerStackDeclarativeSpecification(),IntegerStackImperativeSpecification()} );
    value runResult4 = SimpleSpecificationRunner( suite ).run();
    print( SimpleTextReporter().report( runResult4 ) );
    assert( runResult4.isSuccess );
}
