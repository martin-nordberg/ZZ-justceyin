
import java.util.concurrent {
    JavaCallable = Callable
}

"Adapter converts a Ceylon function to a Java callable."
by "Martin E. Nordberg III"
class CallableAdapter<T>( T task() )
    satisfies JavaCallable<T> {
    
    "Executes the adapted task."
    shared actual T call() {
        return task();
    }
    
}