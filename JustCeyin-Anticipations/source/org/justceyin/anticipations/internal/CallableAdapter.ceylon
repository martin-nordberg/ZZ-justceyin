
import java.util.concurrent {
    JavaCallable = Callable
}

"Adapter converts a Ceylon function to a Java callable."
class CallableAdapter<T>( T task() )
    satisfies JavaCallable<T> {
    
    shared actual T call() {
        return task();
    }
    
}