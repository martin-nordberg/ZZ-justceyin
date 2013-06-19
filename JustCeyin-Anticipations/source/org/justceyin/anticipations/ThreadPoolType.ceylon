
"Enumeration of kinds of thread pool."
by "Martin E. Nordberg III"
shared interface ThreadPoolType
    of cachedThreadPoolType | FixedThreadPoolType 
{
}

"A thread pool where threads are cached for reuse."
by "Martin E. Nordberg III"
shared object cachedThreadPoolType
    satisfies ThreadPoolType 
{
}

"A thread pool with a fixed number of worker threads."
by "Martin E. Nordberg III"
shared class FixedThreadPoolType(
    "The number of threads to allocate in the pool."
    Integer thrdCount 
)
    satisfies ThreadPoolType
{
    "Thread count must be greater than zero."
    assert ( thrdCount > 0 );
    
    "The fixed number of threads to allocate in the pool."
    shared Integer threadCount = thrdCount;
}
