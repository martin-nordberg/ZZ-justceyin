"
 Top level function establishes the start of a declarative asserted expectation. Intended for 
 writing function preconditions.
 
 For example:

 \`\`\` 
 ...
 shared Resource acquireResource() {
     // precondition throws AssertionException (with a very readable message) if no resources available
     constrain( this.availableResourceCount ).named( \"available resources\" ).toBe( anInteger.greaterThan(0) );
 
     ...
 }
 \`\`\`
"
by "Martin E. Nordberg III"
shared AssertedExpectation<T> constrain<T>( 
    "The actual value expected to satisfy some constraint."
    T? actualValue 
) 
    given T satisfies Object 
{
    return AssertedExpectation( expect( actualValue ) );
}
