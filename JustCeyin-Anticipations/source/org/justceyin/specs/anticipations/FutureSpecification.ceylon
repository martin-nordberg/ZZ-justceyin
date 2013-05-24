
import ceylon.math.whole {
    one, 
    Whole,
    wholeNumber
}
import org.justceyin.anticipations { 
    Future, 
    makeCachedThreadPool, 
    ThreadPool 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.expectations.constraints.providers { 
    ComparableConstraints, 
    IntegralConstraints, 
    NumberConstraints 
}
import org.justceyin.specifications {
    ImperativeSpecification
}


"Test function for asynchronous execution"
Whole factorial( Whole n )() {
    if ( n <= one ) {
        return one;
    }
    return n * factorial( n-one )();
}

Whole oneHundred = wholeNumber(100);
Whole oneHundredFactorial = factorial(oneHundred)();

shared object aWholeNumber
    extends ComparableConstraints<Whole>()
    satisfies NumberConstraints<Whole> & IntegralConstraints<Whole> 
{
}

shared class FutureSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "FutureSpecification"; 
    
    "Simple do-nothing specification."
    void testSynchronous( void outcomes( ConstraintCheckResult* results ) ) {
        value result = factorial( oneHundred )();
        
        outcomes( expect( result ).named( "100!" ).toBe( aWholeNumber.withValue( oneHundredFactorial ) ) );
    }
    
    "Simple test of a future"
    void testFuture( void outcomes( ConstraintCheckResult* results ) ) {
        
        ThreadPool pool = makeCachedThreadPool();
        
        Future<Whole> future = pool.computeAsynchronously( factorial(oneHundred) );
        
        Whole result = future.get();
        
        outcomes( expect( result ).named( "100!" ).toBe( aWholeNumber.withValue( oneHundredFactorial ) ) );
    }
    
    "The tests within this specification. (TBD: to be replaced by annotations (M6)."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testSynchronous,
        testFuture
    };

}