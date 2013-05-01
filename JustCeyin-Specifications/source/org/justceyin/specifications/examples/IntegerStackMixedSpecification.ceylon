
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
    MixedSpecification, 
    StartingFrom 
}
import org.justceyin.specifications.requirements { 
    Requirement 
}

"An example of mixing imperative tests and declarative requirements in a single specification."
shared class IntegerStackMixedSpecification()
    satisfies MixedSpecification
{
    
    shared actual String title = "IntegerStackMixedSpecification"; 
    
    // starting values
    Stack<Integer> anEmptyStack() => Stack<Integer>();

    // constraints
    value anIntegerStack = StackConstraints<Integer>();
    
    // declarative requirements
    shared actual {<String->Requirement>+} requirements = {
        
        "A stack starts out empty."->
        StartingFrom( anEmptyStack ).expect( anIntegerStack.thatIsEmpty ),
        
        "Pushing then popping leaves the original stack."->
        StartingFrom( anEmptyStack ).after( pushOntoStack(1) ).followedBy( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
        
        "A pushed value becomes the new top of the stack."->
        StartingFrom( anEmptyStack ).after( pushOntoStack(100) ).followedBy( topOfStack<Integer> ).expect( anInteger.withValue(100) )

    };
    
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
    
    // imperative tests
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testPushThenPopSequence
    };
    
}

///////////////////////////////////////////////////////////////////////////////


