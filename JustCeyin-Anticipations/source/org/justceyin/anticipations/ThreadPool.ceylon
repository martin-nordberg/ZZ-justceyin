
import org.justceyin.anticipations.internal { 
    makeThreadPoolImpl 
}


"Interface to a facility for background multi-threaded execution of submitted tasks."
by "Martin E. Nordberg III"
shared interface ThreadPool
    satisfies Closeable {
    
    "Computes a value in a background thread for future retrieval."
    shared formal Future<T> computeAsynchronously<T>(
        "The task to execute asynchronously returning the future value"
        T task() 
    );
    
}


"Enumeration of kinds of thread pool"
by "Martin E. Nordberg III"
shared interface ThreadPoolType
    of CachedThreadPoolType | FixedThreadPoolType 
{
}

"A thread pool where threads are cached for reuse."
by "Martin E. Nordberg III"
shared class CachedThreadPoolType()
    satisfies ThreadPoolType 
{
}

"A thread pool with a fixed number of worker threads."
by "Martin E. Nordberg III"
shared class FixedThreadPoolType(
    "The number of threads to allocate in the pool."
    Integer thrdCount 
)
    satisfies ThreadPoolType
{
    "The fixed number of threads to allocate in the pool."
    shared Integer threadCount = thrdCount;
}


"Creates a new thread pool of given type."
by "Martin E. Nordberg III"
shared ThreadPool makeThreadPool(
    "The type of thread pool to create."
    ThreadPoolType threadPoolType = CachedThreadPoolType() 
) {
    return makeThreadPoolImpl( threadPoolType );
}
