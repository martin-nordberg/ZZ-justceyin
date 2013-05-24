
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
class FutureAdapter<T>( JavaFuture<T> future )
    satisfies Future<T>{
    
    shared actual T get( Integer? maxWaitTimeMs ) {
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
