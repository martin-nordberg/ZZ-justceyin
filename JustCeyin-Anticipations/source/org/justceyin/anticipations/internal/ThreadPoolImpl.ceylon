
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
class ThreadPoolImpl( JavaExecutorService executor )
    satisfies ThreadPool {
    
    "Computes a value asynchronously in a background thread."
    shared actual Future<T> computeAsynchronously<T>( T task() ) {
        return FutureAdapter( executor.submit( CallableAdapter(task) ) );
    }
    
    
}

shared ThreadPool makeCachedThreadPoolImpl() {
    return ThreadPoolImpl( newCachedThreadPool() );
}

shared ThreadPool makeFixedThreadPool( Integer threadCount ) {
    return ThreadPoolImpl( newFixedThreadPool( threadCount ) );
}
