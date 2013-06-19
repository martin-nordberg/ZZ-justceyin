"
 Package of facilities for concurrent task execution. A thin and narrow wrapper around java.util.concurrent.
 
 The central facility of this package is the concept of a `ThreadPool`. Once created, a thread pool offers two
 ways to compute results in its background threads: futures and continuations.
 
 **Futures**
 
 A future wraps the result of an ordinary Ceylon function call such that the function is executed in a 
 background thread and can be retrieved by the foreground thread (or any other thread) at a later time 
 in a blocking manner.
 
 \`\`\`
     // a long-running function to be executed in a background thread
     MyThing myTimeConsumingFunction() {
         // time consuming code ...
         return MyThing(...);
     }
 
     ThreadPool pool = makeThreadPool();
        
     try /*( pool )*/ {
         pool.open();
         
         // launch a time-consuimng task in a thread from the pool
         Future<Whole> future = pool.computeAsynchronously( myTimeConsumingFunction );
 
         // do something else for a while ...
        
         // get the future result, waiting for it if needed
         MyThing result = future.get();
        
         // use the result ..
     }
     finally {
         pool.close( null );
     }
 \`\`\`
 
 **Continuations**
 
 Continuations are cross-thread callbacks whereby the result of a background thread computation is passed
 to a callback function executing in the foreground thread once the foreground thread is ready to receive
 such callbacks.
 
 \`\`\`
 
     // First task - an ordinary Ceylon function ...
     MyThing myTimeConsumingSingleResultFunction() {
         // time consuming code ...
         return MyThing(...);
     }
 
     // ... converted to continuation-passing style
     value task1 = computeAndContinue( myTimeConsumingSingleResultFunction );
 
     // Second task - a longer-running background task with multiple continuations
     void task2( Anything(MyThing) succeed, Anything(Exception) fail ) {
         while ( /* more to do ... */ ) {
             try {
                 MyThing result = ...;
                 succeed( result )
             }
             catch ( exception e ) {
                 faile(e);
             }
         }
     }
 
     // callbacks
     void success( MyThing result ) {
         // do something useful with result ...
     }
     void failure( Exception e ) {
         // recover from the error ...
     }
        
     ThreadPool pool = makeThreadPool();
        
     try /*( pool )*/ {
         pool.open();
         
         // start up the two tasks
         pool.executeAndContinue<String>( task1, success, failure );
         pool.executeAndContinue<String>( task2, success, failure );
         
         // handle callbacks until both tasks are done
         pool.receiveContinuations();
     }
     finally {
         pool.close( null );
     }

 \`\`\`
 
 The module also provides a handful of higher-order utility functions for converting ordinary functions
 into continuation-passing tasks, composing functions in sequence, etc.
 
 The source code for org.justceyin.anticipations is maintained in GitHub at [https://github.com/martin-nordberg/justceyin](https://github.com/martin-nordberg/justceyin).
"
by "Martin E. Nordberg III"
shared package org.justceyin.anticipations;
