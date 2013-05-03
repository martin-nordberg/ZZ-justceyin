"
 Top level function establishes the start of a declarative expectation.

 For example: 
 \`\`\`
 \"A stack starts out empty.\"
 void testNewStack( void outcomes( ConstraintCheckResult* results ) ) {
    value stack = Stack<Integer>();
              // expected outcomes of the test
    outcomes( expect( stack ).named( \"stack\" ).toBe( anIntegerStack.thatIsEmpty ),
              expect( stack.topIfPresent ).named( \"top of stack\" ).toNotExist() );
 }
 \`\`\`
"
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
