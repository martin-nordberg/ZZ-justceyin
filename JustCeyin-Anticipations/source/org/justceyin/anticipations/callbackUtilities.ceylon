
"Higher order function converts an ordinary value-returning function into a completion callback."
by "Martin E. Nordberg III"
shared void computeAndContinue<T>(
    "A function that returns a result."
    T() baseFunction 
)( 
    "Callback for when the result is computed successfully."
    Anything(T) succeed, 
    "Callback for when the computation fails."
    Anything(Exception) fail 
) {
    
    try {
        T result = baseFunction();
        succeed( result );
    }
    catch ( Exception e ) {
        fail( e );
    }

}


"Higher order function performs two tasks in sequence, calling an outer callback with their tupled results."
by "Martin E. Nordberg III"
shared void doInSequence<in T1, in T2>(
    "First task to be executed."
    Anything( Anything(T1), Anything(Exception) ) task1,
    "Second task to be executed after the first is complete."
    Anything( Anything(T2), Anything(Exception) ) task2
)( 
    "Callback for when the result is computed successfully."
    Anything([T1,T2]) succeed, 
    "Callback for when the computation fails."
    Anything(Exception) fail 
) {

    "First callback launches the second task then tuples up the results."
    void succeed1( T1 result1 ) {
    
        "Second callback tuples up the results and calls the outer callback."
        void succeed2( T2 result2 ) {
            succeed( [result1,result2] );
        }
    
        // perform the second task
        task2( succeed2, fail );
    }
    
    // perform the first task with a callback that continues the sequence
    task1( succeed1, fail );
    
}


"Higher order function performs two tasks in sequence where the second tasks needs the output of 
 the first as its input. The output of the second task goes to the outer callback."
by "Martin E. Nordberg III"
shared void composeSequence<T1,T2>(
    "First task to be executed"
    Anything( Anything(T1), Anything(Exception) ) task1,
    "Second task to be executed with input from the first"
    Anything( T1, Anything(T2), Anything(Exception) ) task2
)( 
    "Callback for when the result is computed successfully."
    Anything(T2) succeed, 
    "Callback for when the computation fails."
    Anything(Exception) fail 
) {

    "Intermediate callback launches the second task, passing it the first result."
    void succeed1( T1 result1 ) {
        task2( result1, succeed, fail );
    }
    
    // perform the first task with a callback that continues the sequence
    task1( succeed1, fail );

}
