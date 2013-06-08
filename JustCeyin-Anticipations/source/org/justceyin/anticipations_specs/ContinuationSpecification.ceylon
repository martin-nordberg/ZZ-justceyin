
import org.justceyin.anticipations { 
    makeContinuationThreadPool, 
    ContinuationThreadPool, computeAndContinue 
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
        
        String baseTask() => "succeeded";
        value task = computeAndContinue( baseTask );
        void success( String result ) => outcome = result;
        void failure( Exception e ) => outcome = e.message;
        
        ContinuationThreadPool pool = makeContinuationThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            
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
        
        String baseTask() => "succeeded";
        value task = computeAndContinue( baseTask );
        void success( String result ) => completionCount += 1;
        void failure( Exception e ) => completionCount += 0;
        
        ContinuationThreadPool pool = makeContinuationThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            pool.executeAndContinue<String>( task, success, failure );
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveContinuations();
        
            outcomes( 
                expect( completionCount ).named( "completion count" ).toBe( anInteger.withValue( 3 ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Tasks begotten by tasks complete before the receipt of continuations ends."
    void testTaskCreatingContinuations( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable Integer taskCount = 0;
        variable Integer completionCount = 0;
        
        ContinuationThreadPool pool = makeContinuationThreadPool();
        
        String baseTask() => "succeeded";
        value task = computeAndContinue( baseTask );

        void failure( Exception e ) => completionCount += 0;
        void success( String result ) {
            completionCount += 1;
            if ( taskCount < 16 ) {
                taskCount += 2;
                pool.executeAndContinue<String>( task, success, failure );
                pool.executeAndContinue<String>( task, success, failure );
            }
        }
        
        try /*( pool )*/ {
            pool.open();
            
            taskCount += 2;
            pool.executeAndContinue<String>( task, success, failure );
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveContinuations();
        
            outcomes( 
                expect( taskCount ).named( "task count" ).toBe( anInteger.withValue( 16 ) ),
                expect( completionCount ).named( "completion count" ).toBe( anInteger.withValue( 16 ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testContinuationComputation,
        testRepeatedContinuations,
        testTaskCreatingContinuations
    };

}