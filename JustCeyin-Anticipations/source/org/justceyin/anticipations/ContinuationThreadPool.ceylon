
import org.justceyin.anticipations.internal { 
    makeContinuationThreadPoolImpl 
}

"Interface to a facility for background multi-threaded execution of continuation-based tasks."
by "Martin E. Nordberg III"
shared interface ContinuationThreadPool
    satisfies Closeable
{
    
    "Repeatedly computes values in a background thread; calls a callback in the original thread for each result."
    shared formal void executeAndContinue<T>(
        "The task to execute in a background thread and then call back into the foreground thread."
        Anything( Anything(T), Anything(Exception) ) task,
        "Function to be called in the event of successful execution of the task."
        Anything(T) succeed,
        "Function to be called in the event of an exception in the execution of the task."
        Anything(Exception) fail
    );
    
    "Allows continuations to call back into this thread. Returns only after there are no more tasks in progress."
    shared formal void receiveContinuations(
        "The maximum length of time to wait for a task to complete in milliseconds. 
         Wait indefinitely if not provided. Note that if multiple continuations are received,
         this is the wait time for any one of them and has no effect on the total time spent."
        Integer? maxWaitTimeMs = null    
    );
    
}

"Creates a new continuation thread pool of given type."
by "Martin E. Nordberg III"
shared ContinuationThreadPool makeContinuationThreadPool(
    "The type of thread pool to create."
    ThreadPoolType threadPoolType = cachedThreadPoolType 
) {
    return makeContinuationThreadPoolImpl( threadPoolType );
}
