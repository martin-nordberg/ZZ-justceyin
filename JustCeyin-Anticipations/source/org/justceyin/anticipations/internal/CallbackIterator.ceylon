
import java.lang {
    Thread {
        javaCurrentThread = currentThread
    }
}
import java.util.concurrent {
    JavaArrayBlockingQueue = ArrayBlockingQueue
}

"An iterator through the callback results of a task executing in a background task."
by "Martin E. Nordberg III"
class CallbackIterator<Element>( Integer queueSize )
    satisfies Iterator<Element>
{
    "The ID of the thread that feeds this iterator."
    late Integer backgroundThreadId;
    
    "The ID of the thread that creates and consumes this iterator."
    Integer foregroundThreadId = javaCurrentThread().id;
    
    "Queue of results to be returned to the foreground thread."
    JavaArrayBlockingQueue< Element|Exception|Finished > resultQueue = JavaArrayBlockingQueue< Element|Exception|Finished >( queueSize );
    
    "Flag to note when the iterator is exhausted."
    variable Boolean done = false;

    "Queues an exception to be thrown in the foreground thread."
    shared void fail( Exception e ) {
        resultQueue.put( e );
    }
    
    "Queues the end of the iterator."
    shared void finish() {
        "Only one background thread is served by a callback iterator."
        assert ( this.backgroundThreadId == javaCurrentThread().id );

        resultQueue.put( finished );
    }
    
    "Reads the next result from the queue."
    shared actual Element|Finished next() {
        "Callback iterator can only be consumed by the thread that created it."
        assert ( this.foregroundThreadId == javaCurrentThread().id );

        // return finished if iterator is exhausted         
        if ( done ) {
            return finished;
        }

        // get the next value from the queue
        value result = resultQueue.take();

        // handle according to type
        if ( is Exception result ) {
            this.done = true;
            throw result;
        }
        if ( is Finished result ) {
            this.done = true;
            return finished;
        }

        assert ( is Element result );
        return result;
    }
    
    "Queues a result."
    shared void put( Element element ) {
        "Only one background thread is served by a callback iterator."
        assert ( this.backgroundThreadId == javaCurrentThread().id );

        resultQueue.put( element );
    }
    
    "Registers the background thread that will be later giving results."
    shared void registerBackgroundThread() {
        backgroundThreadId = javaCurrentThread().id;
    }
    
}