
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
    JavaLinkedBlockingQueue = LinkedBlockingQueue,
    TimeUnit {
        ms = \iMILLISECONDS
    }
}
import java.util.concurrent.atomic {
    JavaAtomicInteger = AtomicInteger
}
import org.justceyin.anticipations { 
    cachedThreadPoolType, 
    FixedThreadPoolType, 
    Future,
    ThreadPool, 
    ThreadPoolType
}

"Thread pool implementation wrapping java.util.concurrent classes for the execution of completion callbacks."
by "Martin E. Nordberg III"
class ThreadPoolImpl( ThreadPoolType threadPoolType )
    satisfies ThreadPool {
    
    "Queue of callbacks to be called back in the foreground thread."
    JavaLinkedBlockingQueue< Anything() > callbackQueue = JavaLinkedBlockingQueue< Anything() >();
    
    "The executor service (thread pool) encasulated by this class."
    late JavaExecutorService executor;
    
    "The ID of the thread that opens this thread pool"
    late Integer foregroundThreadId;
    
    "The current count of tasks executing plus completion callbacks queued."
    variable JavaAtomicInteger todoCount = JavaAtomicInteger(0); 
    
    "Closes the thread pool."
    shared actual void close( Exception? e ) {
        executor.shutdown();
    }
    
    "Computes a value asynchronously in a background thread."
    shared actual Future<T> computeAsynchronously<T>( T task() ) {
        return FutureAdapter( executor.submit( CallableAdapter(task) ) );
    }
    
    "Repeatedly computes values in a background thread; calls a callback in the original thread for each result."
    shared actual void executeAndCallback<T>(
        "The task to execute in a background thread and then call back into the foreground thread."
        Anything( Anything(T), Anything(Exception) ) task,
        "Function to be called in the event of successful execution of the task."
        Anything(T) succeed,
        "Function to be called in the event of an exception in the execution of the task."
        Anything(Exception) fail
    ) {
        "Higher order function completes a failed completion callback."
        void failedCallback( Exception exception, Anything(Exception) fail )() {
            fail( exception );
        }

        "Queues a failed completion callback."
        void failLater( Exception e ) {
            todoCount.incrementAndGet();
            callbackQueue.put( failedCallback( e, fail ) );
        }
        
        "Higher order function completes a successful completion callback."
        void successfulCallback<T>( T result, Anything(T) succeed )() {
            succeed( result );
        }
        
        "Queues a successful completion callback."
        void succeedLater( T result ) {
            todoCount.incrementAndGet();
            callbackQueue.put( successfulCallback( result, succeed ) );
        }
        
        "Wraps the task so that completion callbacks are queued."
        void taskWrapper() {
            try {
                task( succeedLater, failLater );
            }
            catch ( Exception e ) {
                failLater( e );
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

    "Repeatedly (zero to n times) computes values in a background thread; results are available from a blocking iterator/queue."
    shared actual Iterable<T> produceAndConsume<T>(
        "The task to execute in a background thread and then call back with results queued by the iterator."
        Anything( Anything(T), Anything(Exception) ) task,
        "The size of the queue of results between producer and consumer"
        Integer queueSize
    ) {
        CallbackIterator<T> callbackIterator = CallbackIterator<T>( queueSize );
        
        "Queues a failed completion callback."
        void failLater( Exception e ) {
            callbackIterator.fail( e );
        }
        
        "Queues a successful completion callback."
        void succeedLater( T result ) {
            callbackIterator.put( result );
        }
        
        "Wraps the task so that completion callbacks are queued."
        void taskWrapper() {
            try {
                callbackIterator.registerBackgroundThread();
                task( succeedLater, failLater );
            }
            catch ( Exception e ) {
                failLater( e );
            }
            finally {
                callbackIterator.finish();
            }
        }
        
        // submit the task for background thread execution
        executor.submit( CallableAdapter(taskWrapper) );

        // wrap the resulting iterator in a (one time use) iterable
        // TBD: Use the OneTimeIterable class from org.justceyin.foundations if a module dependency
        //      becomes justifiable for other needs.        
        object result
            satisfies Iterable<T> 
        {
            shared actual Iterator<T> iterator() => callbackIterator;
        }
        
        return result;
    }
    
    "Allows completions to call back into this thread. Returns only after there are no more tasks in progress."
    shared actual void receiveCompletionCallbacks(
        "The maximum length of time to wait for a task to complete in milliseconds. 
         Wait indefinitely if not provided. Note that if multiple callbacks are received,
         this is the wait time for any one of them and has no effect on the total time spent."
        Integer? maxWaitTimeMs    
    ) {
        "Completion callbacks can only be received by the thread that opened the pool"
        assert ( this.foregroundThreadId == javaCurrentThread().id );
        
        // loop while there are executing tasks or unfinished callbacks
        while ( todoCount.get() > 0 ) {
            // execute the next callback, waiting for it if needed
            if ( exists maxWaitTimeMs ) {
                this.callbackQueue.poll( maxWaitTimeMs, ms )();
            }
            else {
                this.callbackQueue.take()();
            }

            todoCount.decrementAndGet();
        }
    }
}

"Creates a thread pool."
by "Martin E. Nordberg III"
shared ThreadPool makeThreadPoolImpl( ThreadPoolType threadPoolType ) {
    return ThreadPoolImpl( threadPoolType );
}

