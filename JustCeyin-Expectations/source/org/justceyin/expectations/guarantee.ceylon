"
 Top level function establishes the start of a declarative asserted expectation. Intended for
 writing function postconditions.
 
 For example:
 
 \`\`\`
 \"Pads a string with extra characters if it is shorter than some desired length.\"
 shared String padString( String text, Integer minSize, String pad=\".\" ) {

     variable StringBuilder result = StringBuilder();
     result.append( text );
     while ( result.size < minSize ) { result.append( pad ); }
     
     // postcondition (throws AssertionException if not satisfied)
     guarantee( result.string ).named( \"truncated string\" ).toBe( aString.withMinimumLength( minSize ) );
     
     return result.string;
 }
 \`\`\`
"
by "Martin E. Nordberg III"
shared AssertedExpectation<T> guarantee<T>( 
    "The actual value expected to satisfy some constraint."
    T? actualValue 
) 
    given T satisfies Object 
{
    return AssertedExpectation( expect( actualValue ) );
}

