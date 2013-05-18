
import org.justceyin.expectations.constraints {
    ConstraintCheckResult, 
    ConstraintCheckComposite
}

"
 Specification mixin defined in terms of a number of test functions to be executed.

 Below is a complete example for a specification derived from this mixin. This code is from 
 package org.justceyin.specifications.examples within this module.
 
 \`\`\`
 \"An example specification illustrating how to go about creating an imperative specification defined in
  terms of test methods, where each requirement uses the fluent interface of org.justceyin.expectations
  to declare expected outcomes for the results of the test.\"
 shared class IntegerStackImperativeSpecification()
     satisfies ImperativeSpecification
 {
    
     shared actual String title = \"IntegerStackImperativeSpecification\"; 
    
     // constraints
     value anIntegerStack = StackConstraints<Integer>();
    
     \"A stack starts out empty.\"
     void testNewStack( void outcomes( ConstraintCheckResult* results ) ) {
         value stack = Stack<Integer>();
         outcomes( expect( stack ).named( \"stack\" ).toBe( anIntegerStack.thatIsEmpty ),
                   expect( stack.topIfPresent ).named( \"top of stack\" ).toNotExist() );
     }
    
     \"A pushed value becomes the new top of the stack.\"
     void testPush( void outcomes( ConstraintCheckResult* results ) ) {
         value stack = Stack<Integer>().push(1);
         outcomes( expect( stack.top ).named( \"top of stack\" ).toBe( anInteger.withValue(1) ) );
     }
    
     \"Pushing then popping leaves the original stack.\"
     void testPushThenPop( void outcomes( ConstraintCheckResult* results ) ) {
         value stack = Stack<Integer>().push(1).pop();
         outcomes( expect( stack ).named( \"stack\" ).toBe( anIntegerStack.thatIsEmpty ),
                   expect( stack.topIfPresent ).named( \"top of stack\" ).toNotExist() );
     }
    
     \"Pushing then popping leaves the original stack (intermediate steps checked).\"
     void testPushThenPopSequence( void outcomes( ConstraintCheckResult* results ) ) {
         value stack0 = Stack<Integer>();
        
         outcomes( expect( stack0 ).named( \"stack\" ).toBe( anIntegerStack.thatIsEmpty ),
                   expect( stack0.topIfPresent ).named( \"top of stack\" ).toNotExist() );

         value stack1 = stack0.push( 1 );
        
         outcomes( expect( stack1.top ).named( \"top of stack\" ).toBe( anInteger.withValue(1) ) );
        
         value stack2 = stack1.pop();
        
         outcomes( expect( stack2 ).named( \"stack\" ).toBe( anIntegerStack.thatIsEmpty ),
                   expect( stack2.topIfPresent ).named( \"top of stack\" ).toNotExist() );
     }
    
     \"The tests within this specification. (TBD: to be replaced by annotations (M6).\"
     shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
         testNewStack,
         testPush,
         testPushThenPop,
         testPushThenPopSequence
     };
    
 }
"
by "Martin E. Nordberg III"
shared interface ImperativeSpecification 
    satisfies Specification
{
    
    "The title of this specification."
    shared formal String title;
        // TBD: Derive the title from the doc annotation (M6) of a derived class
    
    // TBD: use results in compiler bug
//    "Type alias for use in derived class tests."
//    shared alias Outcomes => Anything ( ConstraintCheckResult* );
    
    "The tests (in a derived class to be executed). Each test passes back one or 
     more constraint checking results to an outcomes callback that accumulates them into
     a composite constraint checking result."
    shared formal {Anything(Anything ( ConstraintCheckResult* ))+} tests;
    
    "Execute the tests defined in a derived class."
    shared actual default ConstraintCheckResult check() {
        
        variable [ConstraintCheckResult*] testResults = [];

        "Accumulates the results of individual tests into a composite result."
        void outcomes( ConstraintCheckResult* moreResults ) {
            moreResults.collect( (ConstraintCheckResult r) => testResults = testResults.withLeading( r ) );
        }
        
        variable [ConstraintCheckResult*] specResults = [];
        
        // iterate over the tests
        for ( test in tests ) {
            // compile the results of one test
            testResults = [];
            test( outcomes );
            value testResult = ConstraintCheckComposite( "Test Result (TBD)", testResults.reversed );

            // add each test result to the spec result
            specResults = specResults.withLeading( testResult );
        }
        
        // bundle the overall results
        return ConstraintCheckComposite( this.title, specResults.reversed );
    }

}
