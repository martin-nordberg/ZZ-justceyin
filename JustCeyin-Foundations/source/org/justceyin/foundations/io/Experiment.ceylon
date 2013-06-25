
/**
shared interface Closeable {
    "Closes this resource"
    shared formal void close();
}

shared interface Openable<T>
    given T satisfies Closeable {
    
    "Creates and opens a new resource."
    shared formal T open();
}

shared interface MyResource
    satisfies Closeable {
 
    "The work of the resource (known to be open)."
    shared formal void doStuffWithKnownToBeOpenResource();
}

shared class MyConcreteResource()
    satisfies MyResource {
    
    /* open the resource during initialization ... */
    
    shared actual void close() { /*...*/ }
    
    shared actual void doStuffWithKnownToBeOpenResource() { /*...*/ }
}

shared class MyResourceSupplier()
    satisfies Openable<MyResource> {
    
    shared actual MyResource open() => MyConcreteResource();
}


void directClient() {
    try ( resource = MyConcreteResource() ) {
        resource.doStuffWithKnownToBeOpenResource();
    }
    catch ( Exception e ) {
        // ...
    }
}

void indirectClient( MyResourceSupplier supplier ) {
    try ( resource = supplier.open() ) {
        
    }
    catch ( Exception e ) {
        // ...
    }
}
**/