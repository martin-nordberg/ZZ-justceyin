
import java.util.concurrent {
    JavaFuture = Future,
    TimeUnit {
        ms = \iMILLISECONDS
    }
}
import org.justceyin.anticipations { 
    Future
}

"Adapter wraps a Java Future in a Ceylon interface."
by "Martin E. Nordberg III"
class FutureAdapter<T>( JavaFuture<T> future )
    satisfies Future<T>{
    
    "Cancels the computation of this future"
    shared actual void cancel( 
        "Whether the task computing this future may be interrupted if currently running."
        Boolean mayInterruptIfRunning 
    ) {
        future.cancel( mayInterruptIfRunning );
    }
    
    "Whether this future was canceled"
    shared actual Boolean canceled => this.future.cancelled;
    
    "Whether the task producing this future value is done."
    shared actual Boolean done => this.future.done;
    
    "Returns the underlying value of this future."
    shared actual T get( 
        "The maximum length of time to wait for the result in milliseconds. 
         Wait indefinitely if not provided."
        Integer? maxWaitTimeMs 
    ) {
        T? result;
        if ( exists maxWaitTimeMs ) {
            result = future.get( maxWaitTimeMs, ms );
        }
        else {
            result = future.get();
        }
        
        "Result always expected to exist because of Anticipations API around Java code."
        assert (exists result);
        
        return result;
    }
}
