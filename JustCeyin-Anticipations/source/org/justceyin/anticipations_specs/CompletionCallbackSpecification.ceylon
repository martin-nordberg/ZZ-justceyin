
import java.lang {
    Thread {
        javaCurrentThread = currentThread
    }
}
import org.justceyin.anticipations { 
    composeSequence, 
    computeAndContinue, 
    doInSequence, 
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
    aString
}
import org.justceyin.specifications {
    ImperativeSpecification
}


"Specification ensures that completion callbacks operate as expected."
by "Martin E. Nordberg III"
shared class CompletionCallbackSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "CompletionCallbackSpecification"; 
    
    "A completion callback passes back a successful result."
    void testCompletionCallbackComputation( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable String outcome = "unfinished";
        
        String baseTask() => "succeeded";
        value task = computeAndContinue( baseTask );
        void success( String result ) => outcome = result;
        void failure( Exception e ) => outcome = e.message;
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( outcome ).named( "outcome" ).toBe( aString.withValue( "succeeded" ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Multiple tasks complete before the receipt of callbacks ends."
    void testRepeatedCallbacks( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable Integer completionCount = 0;
        
        String baseTask() => "succeeded";
        value task = computeAndContinue( baseTask );
        void success( String result ) => completionCount += 1;
        void failure( Exception e ) => completionCount += 0;
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            pool.executeAndContinue<String>( task, success, failure );
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( completionCount ).named( "completion count" ).toBe( anInteger.withValue( 3 ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "A continued task executes in a background thread then continues in the foreground thread."
    void testCompletionCallbackThreading( void outcomes( ConstraintCheckResult* results ) ) {
        
        value foregroundThreadName = javaCurrentThread().name;
        variable String taskThreadName = "unfinished";
        variable String callbackThreadName = "unknown";
        
        String baseTask() => javaCurrentThread().name;
        value task = computeAndContinue( baseTask );
        void success( String result ) {
            taskThreadName = result;
            callbackThreadName = javaCurrentThread().name;
        }
        void failure( Exception e ) => taskThreadName = e.message;
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( callbackThreadName ).named( "callback thread name" ).toBe( aString.withValue( foregroundThreadName ) ),
                expect( taskThreadName ).named( "task thread name" ).toBe( aString.notEqualTo( foregroundThreadName ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Tasks begotten by tasks complete before the receipt of callbacks ends."
    void testTaskCreatingMoreTasks( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable Integer taskCount = 0;
        variable Integer completionCount = 0;
        
        ThreadPool pool = makeThreadPool();
        
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
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( taskCount ).named( "task count" ).toBe( anInteger.withValue( 16 ) ),
                expect( completionCount ).named( "completion count" ).toBe( anInteger.withValue( 16 ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Individually continuing tasks can be executed in sequence."
    void testTasksInSequence( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable [String,String] outcome = ["unfinished","unfinished"];
        
        String baseTask( String result )() => result;
        value task1 = computeAndContinue( baseTask("task 1 succeeded") );
        value task2 = computeAndContinue( baseTask("task 2 succeeded") );
        value task = doInSequence( task1, task2 );
        void success( [String,String] result ) => outcome = result;
        void failure( Exception e ) => outcome = ["failed",e.message];
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<[String,String]>( task, success, failure );
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( outcome[0] ).named( "outcome 1" ).toBe( aString.withValue( "task 1 succeeded" ) ),
                expect( outcome[1] ).named( "outcome 2" ).toBe( aString.withValue( "task 2 succeeded" ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Individually continuing tasks can be composed in sequence."
    void testComposedTasks( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable String outcome = "unfinished";
        
        void task1( Anything(Integer) succeed, Anything(Exception) fail ) {
            succeed( 1 );
        }
        void task2( Integer input, Anything(String) succeed, Anything(Exception) fail ) {
            succeed( "Task ``input`` then task 2" );
        }
        value task = composeSequence<Integer,String>( task1, task2 );
        void success( String result ) => outcome = result;
        void failure( Exception e ) => outcome = e.message;
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( outcome ).named( "outcome" ).toBe( aString.withValue( "Task 1 then task 2" ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "Tasks with repeated callbacks are handled until complete."
    void testRepeatingTask( void outcomes( ConstraintCheckResult* results ) ) {
        
        variable String outcome = "";
        
        void task( Anything(String) succeed, Anything(Exception) fail ) {
            succeed( "a" );
            succeed( "b" );
            succeed( "c" );
            succeed( "d" );
        }
        void success( String result ) => outcome += result;
        void failure( Exception e ) => outcome += e.message;
        
        ThreadPool pool = makeThreadPool();
        
        try /*( pool )*/ {
            pool.open();
            
            pool.executeAndContinue<String>( task, success, failure );
            
            pool.receiveCompletionCallbacks();
        
            outcomes( 
                expect( outcome ).named( "outcome" ).toBe( aString.withLength( 4 ) )
            );
        }
        finally {
            pool.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testCompletionCallbackComputation,
        testRepeatedCallbacks,
        testCompletionCallbackThreading,
        testTaskCreatingMoreTasks,
        testTasksInSequence,
        testComposedTasks,
        testRepeatingTask
    };

}