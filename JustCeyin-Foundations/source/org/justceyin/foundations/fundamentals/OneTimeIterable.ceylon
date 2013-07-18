

"Implementation of Iterable that supports only one time use of the core iterator."
shared class OneTimeIterable<T>(
    Iterator<T> onceUsedIterator
)
    satisfies Iterable<T>
{
    
    "Flag enforcing one time use."
    variable Boolean alreadyUsed = false; 
    
    "Returns the iterator within this iterable. Can be called only once. Copy the results 
     into a sequence for repeatable use if that is needed."
    shared actual Iterator<T> iterator() {
        if ( this.alreadyUsed ) {
            throw Exception( "Iterator can be used only once." );
        }
        
        this.alreadyUsed = true;
        
        return this.onceUsedIterator;
    }

}
