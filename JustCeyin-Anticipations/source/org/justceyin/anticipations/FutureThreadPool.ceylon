
import org.justceyin.anticipations.internal { 
    makeFutureThreadPoolImpl 
}


"Interface to a facility for background multi-threaded execution of submitted tasks."
by "Martin E. Nordberg III"
shared interface FutureThreadPool
    satisfies Closeable
{
    
    "Computes a value in a background thread for future retrieval."
    shared formal Future<T> computeAsynchronously<T>(
        "The task to execute asynchronously returning the future value"
        T task() 
    );
    
}

"Creates a new thread pool of given type for computing futures."
by "Martin E. Nordberg III"
shared FutureThreadPool makeFutureThreadPool(
    "The type of thread pool to create."
    ThreadPoolType threadPoolType = cachedThreadPoolType 
) {
    return makeFutureThreadPoolImpl( threadPoolType );
}
