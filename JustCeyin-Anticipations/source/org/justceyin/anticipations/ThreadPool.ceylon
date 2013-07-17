
import org.justceyin.anticipations.internal { 
    makeThreadPoolImpl 
}

"Interface to a facility for background multi-threaded execution of futures or completion callback-based tasks."
by "Martin E. Nordberg III"
shared interface ThreadPool
    satisfies Closeable
{
    
    "Computes a value in a background thread for future retrieval."
    shared formal Future<T> computeAsynchronously<T>(
        "The task to execute asynchronously returning the future value"
        T task() 
    );
    
    "Repeatedly (zero to n times) computes values in a background thread; calls a callback in the original thread for each result."
    shared formal void executeAndCallback<T>(
        "The task to execute in a background thread and then call back into the foreground thread."
        Anything( Anything(T), Anything(Exception) ) task,
        "Function to be called in the event of successful execution of the task."
        Anything(T) succeed,
        "Function to be called in the event of an exception in the execution of the task."
        Anything(Exception) fail
    );
    
    "Repeatedly (zero to n times) computes (produces) values in a background thread; results are available from
     a blocking iterator/queue that operates in the foreground thread. Note that because it is backed by a queue,
     the iterable result can only be traversed once."
    shared formal Iterable<T> produceAndConsume<T>(
        "The task to execute in a background thread and then call back with results queued by the iterator."
        Anything( Anything(T), Anything(Exception) ) task,
        "The size of the queue of results between producer and consumer"
        Integer queueSize = 256
    );
    
    "Allows completion callbacks to call back into this thread. Returns only after there are no more tasks in progress."
    shared formal void receiveCompletionCallbacks(
        "The maximum length of time to wait for a task to complete in milliseconds. 
         Wait indefinitely if not provided. Note that if multiple callbacks are received,
         this is the wait time for any one of them and has no effect on the total time spent."
        Integer? maxWaitTimeMs = null    
    );
    
}

"Creates a new thread pool of given type."
by "Martin E. Nordberg III"
shared ThreadPool makeThreadPool(
    "The type of thread pool to create."
    ThreadPoolType threadPoolType = cachedThreadPoolType 
) {
    return makeThreadPoolImpl( threadPoolType );
}
