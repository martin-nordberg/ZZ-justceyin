
import ceylon.math.whole {
    one, 
    Whole,
    wholeNumber
}
import java.lang {
    Thread {
        javaCurrentThread = currentThread
    }
}
import org.justceyin.anticipations { 
    Future, 
    makeThreadPool, 
    ThreadPool 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.expectations.constraints.providers { 
    aString, 
    aBoolean 
}
import org.justceyin.expectations_extras.providers { 
    aWholeNumber 
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

"Test function for ensuring background thread"
String getThreadName() {
    return javaCurrentThread().name;
}


"Specification ensures that a future is computed as expected."
shared class FutureSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "FutureSpecification"; 
    
    "A normal single-threaded equivalent to the future test computes the right value."
    void testSingleThreaded( void outcomes( ConstraintCheckResult* results ) ) {
        value result = factorial( oneHundred )();
        
        outcomes( expect( result ).named( "100!" ).toBe( aWholeNumber.withValue( oneHundredFactorial ) ) );
    }
    
    "The value of a future is computed as expected."
    void testFutureComputation( void outcomes( ConstraintCheckResult* results ) ) {
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            Future<Whole> future = pool.computeAsynchronously( factorial(oneHundred) );
        
            Whole result = future.get();
        
            outcomes( 
                expect( result ).named( "100!" ).toBe( aWholeNumber.withValue( oneHundredFactorial ) ),
                expect( future.done ).named( "future.done" ).toBe( aBoolean.thatIsTrue )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Test that a future can be canceled."
    void testFutureCancelation( void outcomes( ConstraintCheckResult* results ) ) {
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            Future<Whole> future = pool.computeAsynchronously( factorial(oneHundred) );
        
            future.cancel();
        
            outcomes( expect( future.canceled ).named( "future.canceled" ).toBe( aBoolean.thatIsTrue ) );
        }
        finally {
            pool.close( null );
        }
    }
    
    "A future is computed in a background thread, not the main thread."
    void testFutureInBackgroundThread( void outcomes( ConstraintCheckResult* results ) ) {
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            Future<String> future = pool.computeAsynchronously( getThreadName );

            String mainThreadName = getThreadName();
            String backgroundThreadName = future.get();
        
            outcomes( expect( backgroundThreadName ).named( "background thread name" ).toBe( aString.notEqualTo( mainThreadName ) ) );
        }
        finally {
            pool.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testSingleThreaded,
        testFutureComputation,
        testFutureCancelation,
        testFutureInBackgroundThread
    };

}