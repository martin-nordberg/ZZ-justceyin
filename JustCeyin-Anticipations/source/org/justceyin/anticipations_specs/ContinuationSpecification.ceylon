
import org.justceyin.anticipations { 
    makeContinuationThreadPool, 
    ContinuationThreadPool 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.expectations.constraints.providers { 
    aString, anInteger 
}
import org.justceyin.specifications {
    ImperativeSpecification
}


"Specification ensures that continuations operate as expected."
by "Martin E. Nordberg III"
shared class ContinuationSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "ContinuationSpecification"; 
    
    "A continuation passes back a successful result."
    void testContinuationComputation( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable String outcome = "unfinished";
        
        String task() => "succeeded";
        void success( String result ) => outcome = result;
        void failure( Exception e ) => outcome = e.message;
        
        ContinuationThreadPool pool = makeContinuationThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue( task, success, failure );
            
            pool.receiveContinuations();
        
            outcomes( 
                expect( outcome ).named( "outcome" ).toBe( aString.withValue( "succeeded" ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Multiple tasks complete before the receipt of continuations ends."
    void testRepeatedContinuations( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable Integer completionCount = 0;
        
        String task() => "succeeded";
        void success( String result ) => completionCount += 1;
        void failure( Exception e ) => completionCount += 0;
        
        ContinuationThreadPool pool = makeContinuationThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue( task, success, failure );
            pool.executeAndContinue( task, success, failure );
            pool.executeAndContinue( task, success, failure );
            
            pool.receiveContinuations();
        
            outcomes( 
                expect( completionCount ).named( "completion count" ).toBe( anInteger.withValue( 3 ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testContinuationComputation,
        testRepeatedContinuations
    };

}