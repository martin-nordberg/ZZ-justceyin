
import java.util.concurrent {
    Executors {
        newCachedThreadPool,
        newFixedThreadPool
    },
    
    JavaExecutorService = ExecutorService
}
import org.justceyin.anticipations { 
    Future,
    ThreadPool 
}


"Thread pool implementation wrapping java.util.concurrent classes."
class ThreadPoolImpl( Integer threadCount = 0 )
    satisfies ThreadPool {
    
    late variable JavaExecutorService executor;
    
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
        if ( threadCount < 1 ) {
            this.executor = newCachedThreadPool();
        }
        else {
            this.executor = newFixedThreadPool( threadCount );
        }
    }
}

shared ThreadPool makeCachedThreadPoolImpl() {
    return ThreadPoolImpl();
}

shared ThreadPool makeFixedThreadPool( Integer threadCount ) {
    return ThreadPoolImpl( threadCount );
}
