
import java.util.concurrent {
    Executors {
        newCachedThreadPool,
        newFixedThreadPool
    },
    
    JavaExecutorService = ExecutorService
}
import org.justceyin.anticipations { 
    CachedThreadPoolType, 
    Future,
    ThreadPool, 
    ThreadPoolType, FixedThreadPoolType
}


"Thread pool implementation wrapping java.util.concurrent classes."
by "Martin E. Nordberg III"
class ThreadPoolImpl( ThreadPoolType threadPoolType )
    satisfies ThreadPool {
    
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
        if ( is CachedThreadPoolType threadPoolType ) {
            this.executor = newCachedThreadPool();
        }
        else if ( is FixedThreadPoolType threadPoolType ) {
            this.executor = newFixedThreadPool( threadPoolType.threadCount );
        }
    }
}

shared ThreadPool makeThreadPoolImpl( ThreadPoolType threadPoolType ) {
    return ThreadPoolImpl( threadPoolType );
}

