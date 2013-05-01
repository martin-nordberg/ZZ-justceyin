
"Top level function establishes the start of a declarative asserted expectation. Intended for 
 writing function preconditions."
by "Martin E. Nordberg III"
shared AssertedExpectation<T> constrain<T>( 
    "The actual value expected to satisfy some constraint."
    T? actualValue 
) 
    given T satisfies Object 
{
    return AssertedExpectation( expect( actualValue ) );
}

