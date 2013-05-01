
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult
}
import org.justceyin.expectations.constraints.providers { 
    anInteger 
}
import org.justceyin.specifications { 
    ImperativeSpecification 
}

shared class IntegerStackImperativeSpecification()
    satisfies ImperativeSpecification
{
    
    shared actual String title = "IntegerStackImperativeSpecification"; 
    
    // constraints
    value anIntegerStack = StackConstraints<Integer>();
    
    "A stack starts out empty."
    void testNewStack( void outcomes( ConstraintCheckResult* results ) ) {
        value stack = Stack<Integer>();
        outcomes( expect( stack ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                  expect( stack.topIfPresent ).named( "top of stack" ).toNotExist() );
    }
    
    "A pushed value becomes the new top of the stack."
    void testPush( void outcomes( ConstraintCheckResult* results ) ) {
        value stack = Stack<Integer>().push(1);
        outcomes( expect( stack.top ).named( "top of stack" ).toBe( anInteger.withValue(1) ) );
    }
    
    "Pushing then popping leaves the original stack."
    void testPushThenPop( void outcomes( ConstraintCheckResult* results ) ) {
        value stack = Stack<Integer>().push(1).pop();
        outcomes( expect( stack ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                  expect( stack.topIfPresent ).named( "top of stack" ).toNotExist() );
    }
    
    "Pushing then popping leaves the original stack (intermediate steps checked)."
    void testPushThenPopSequence( void outcomes( ConstraintCheckResult* results ) ) {
        value stack0 = Stack<Integer>();
        
        outcomes( expect( stack0 ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                  expect( stack0.topIfPresent ).named( "top of stack" ).toNotExist() );

        value stack1 = stack0.push( 1 );
        
        outcomes( expect( stack1.top ).named( "top of stack" ).toBe( anInteger.withValue(1) ) );
        
        value stack2 = stack1.pop();
        
        outcomes( expect( stack2 ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                  expect( stack2.topIfPresent ).named( "top of stack" ).toNotExist() );
    }
    
    "The tests within this specification. (TBD: to be replaced by annotations (M6)."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testNewStack,
        testPush,
        testPushThenPop,
        testPushThenPopSequence
    };
    
}

