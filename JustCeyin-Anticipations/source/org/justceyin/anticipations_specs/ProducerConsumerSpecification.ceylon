
import ceylon.math.whole {
    one, 
    Whole
}
import org.justceyin.anticipations { 
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
    anInteger, 
    aWholeNumber 
}
import org.justceyin.specifications {
    ImperativeSpecification
}


"Loop through the values of n!"
void generateFactorials( Anything(Whole) yield, Anything(Exception) fail ) {
    variable Whole nFactorial = one;
    variable Whole n = one;
    for ( i in 1..100 ) {
        yield( nFactorial );
        n += one;
        nFactorial *= n;
    }
}


"Specification ensures that a producer/consumer iteration operates as expected."
by "Martin E. Nordberg III"
shared class ProducerConsumerSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "ProducerConsumerSpecification"; 
    
    "The values from a background thread producer can be consumed via iterator."
    void testProducerConsumer( void outcomes( ConstraintCheckResult* results ) ) {
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            value factorials = pool.produceAndConsume<Whole>( generateFactorials );
        
            variable Integer count = 0;
            variable Whole result = one;
            for ( nf in factorials ) {
                count += 1;
                result = nf;
            }
        
            outcomes( 
                expect( count ).named( "count" ).toBe( anInteger.withValue( 100 ) ),
                expect( result ).named( "100!" ).toBe( aWholeNumber.greaterThan( one ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testProducerConsumer
    };

}