
import java.lang {
    Thread {
        javaCurrentThread = currentThread
    }
}
import java.util.concurrent {
    Executors {
        javaNewCachedThreadPool = newCachedThreadPool,
        javaNewFixedThreadPool = newFixedThreadPool
    },
    JavaExecutorService = ExecutorService,
    JavaLinkedBlockingQueue = LinkedBlockingQueue
}
import java.util.concurrent.atomic {
    JavaAtomicInteger = AtomicInteger
}
import org.justceyin.anticipations { 
    cachedThreadPoolType, 
    ContinuationThreadPool, 
    FixedThreadPoolType, 
    ThreadPoolType
}

"Thread pool implementation wrapping java.util.concurrent classes for the execution of continuations."
by "Martin E. Nordberg III"
class ContinuationThreadPoolImpl( ThreadPoolType threadPoolType )
    satisfies ContinuationThreadPool {
    
    "Queue of continuations to be called back in the foreground thread."
    JavaLinkedBlockingQueue< Anything() > continuationQueue = JavaLinkedBlockingQueue< Anything() >();
    
    "The executor service (thread pool) encasulated by this class."
    late JavaExecutorService executor;
    
    "The ID of the thread that opens this thread pool"
    late Integer foregroundThreadId;
    
    "The current count of tasks executing plus continuations queued."
    variable JavaAtomicInteger todoCount = JavaAtomicInteger(0); 
    
    "Higher order function completes a successful continuation."
    void successfulContinuation<T>( T result, Anything(T) succeed )() {
        succeed( result );
    }
    
    "Higher order function completes a failed continuation."
    void failedContinuation( Exception exception, Anything(Exception) fail )() {
        fail( exception );
    }

    "Closes the thread pool."
    shared actual void close( Exception? e ) {
        executor.shutdown();
    }
    
    "Computes a value in a background thread then calls a callback in the original thread when done."
    shared actual void executeAndContinue<T>(
        "The task to execute in a background thread and then call back into the foreground thread."
        T() task,
        "Function to be called in the event of successful execution of the task."
        Anything(T) succeed,
        "Function to be called in the event of an exception in the execution of the task."
        Anything(Exception) fail
    ) {
        "Wraps the task so that its result is sent back in a continuation."
        void taskWrapper() {
            try {
                T result = task();
                continuationQueue.put( successfulContinuation( result, succeed ) );
            }
            catch ( Exception e ) {
                continuationQueue.put( failedContinuation( e, fail ) );
            }
        }
        
        // submit the task for background thread execution
        todoCount.incrementAndGet();
        executor.submit( CallableAdapter(taskWrapper) );
    }
    
    "Repeatedly computes values in a background thread; calls a callback in the original thread for each result."
    shared actual void executeWithContinuations<T>(
        "The task to execute in a background thread and then call back into the foreground thread."
        Anything( Anything(T), Anything(Exception) ) task,
        "Function to be called in the event of successful execution of the task."
        Anything(T) succeed,
        "Function to be called in the event of an exception in the execution of the task."
        Anything(Exception) fail
    ) {
        "Queues a successful continuation."
        void succeedLater( T result ) {
            todoCount.incrementAndGet();
            continuationQueue.put( successfulContinuation( result, succeed ) );
        }
        
        "Queues a failed continuation."
        void failLater( Exception e ) {
            todoCount.incrementAndGet();
            continuationQueue.put( failedContinuation( e, fail ) );
        }
        
        "Wraps the task so that callbacks become queued continuations."
        void taskWrapper() {
            try {
                task( succeedLater, failLater );
            }
            finally {
                todoCount.decrementAndGet();
            }
        }
        
        // submit the task for background thread execution
        todoCount.incrementAndGet();
        executor.submit( CallableAdapter(taskWrapper) );
    }
    
    "Opens the thread pool."
    shared actual void open() {
        if ( cachedThreadPoolType == threadPoolType ) {
            this.executor = javaNewCachedThreadPool();
        }
        else if ( is FixedThreadPoolType threadPoolType ) {
            this.executor = javaNewFixedThreadPool( threadPoolType.threadCount );
        }
        
        foregroundThreadId = javaCurrentThread().id;
    }

    "Allows continuations to call back into this thread. Returns only after there are no more tasks in progress."
    shared actual void receiveContinuations() {
        "Waiting must be done by the thread that opened the pool"
        assert ( this.foregroundThreadId == javaCurrentThread().id );
        
        // loop while there are executing tasks or unfinished continuations
        while ( todoCount.get() > 0 ) {
            // execute the next continuation, waiting for it if needed
            this.continuationQueue.take()();

            todoCount.decrementAndGet();
        }
    }
}

"Creates a continuation thread pool."
by "Martin E. Nordberg III"
shared ContinuationThreadPool makeContinuationThreadPoolImpl( ThreadPoolType threadPoolType ) {
    return ContinuationThreadPoolImpl( threadPoolType );
}

