

shared interface Future<T> {
    
    shared formal T get( Integer? maxWaitTimeMs = null );
    
}