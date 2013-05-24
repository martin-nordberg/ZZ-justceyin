
import org.justceyin.anticipations.internal { 
    makeCachedThreadPoolImpl 
}


"Interface to a facility for background multi-threaded execution of submitted tasks."
shared interface ThreadPool {
    
    "Computes a value in a background thread for future retrieval."
    shared formal Future<T> computeAsynchronously<T>(
        "The task to execute asynchronously returning the future value"
        T task() 
    );
    
}

shared ThreadPool makeCachedThreadPool() {
    return makeCachedThreadPoolImpl();
}