
"Top level function establishes the start of a declarative expectation."
by "Martin E. Nordberg III"
shared Expectation<T> expect<T>( 
    "The actual value expected to satisfy some constraint."
    T? actualValue 
) 
    given T satisfies Object 
{
    if ( exists actualValue ) {
        return ExistentExpectation( actualValue ); 
    }
    return NonexistentExpectation<T>();
}
