
import java.util.concurrent {
    Executors {
        javaNewCachedThreadPool = newCachedThreadPool,
        javaNewFixedThreadPool = newFixedThreadPool
    },
    JavaExecutorService = ExecutorService
}
import org.justceyin.anticipations { 
    cachedThreadPoolType, 
    FixedThreadPoolType, 
    Future,
    FutureThreadPool, 
    ThreadPoolType
}


"Thread pool implementation for computing futures by wrapping java.util.concurrent classes."
by "Martin E. Nordberg III"
class FutureThreadPoolImpl( ThreadPoolType threadPoolType )
    satisfies FutureThreadPool {
    
    "The executor service (thread pool) encasulated by this class."
    late JavaExecutorService executor;
    
    "Computes a value asynchronously in a background thread."
    shared actual Future<T> computeAsynchronously<T>( T task() ) {
        return FutureAdapter( executor.submit( CallableAdapter(task) ) );
    }
    
    "Closes the thread pool."
    shared actual void close( Exception? e ) {
        executor.shutdown();
    }
    
    "Opens the thread pool."
    shared actual void open() {
        if ( cachedThreadPoolType == threadPoolType ) {
            this.executor = javaNewCachedThreadPool();
        }
        else if ( is FixedThreadPoolType threadPoolType ) {
            this.executor = javaNewFixedThreadPool( threadPoolType.threadCount );
        }
    }

}

"Creates a future thread pool."
by "Martin E. Nordberg III"
shared FutureThreadPool makeFutureThreadPoolImpl( ThreadPoolType threadPoolType ) {
    return FutureThreadPoolImpl( threadPoolType );
}

