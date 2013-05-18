
import org.justceyin.expectations.constraints { 
    Constraint 
}

"Intermediate result in a fluent interface for declarative specifications - represents a set of starting values
 and a set up operation that transforms those starting values into a testable outcome."
by "Martin E. Nordberg III"
shared class Behavior<Input,Output>(
    "Sequence of functions providing starting values for the requirement."
    {Input()+} startingValues, 
    "Operation to be applied to an input to generate the testable output."
    Output setup( Input input ) 
) {
    
    "Defines a requirement by applying a constraint to the transformed output."
    shared Requirement expect(
        "A constraint that should be satisfied by the transformed output value"
        Constraint<Output> constraint 
    ) {
        return BehaviorRequirement<Input,Output>( startingValues, setup, constraint );
    }
    
    "Defines a requirement that expects an exception to be thrown by the setup/transform process."
    shared Requirement expectAnException<ExceptionType>()
        given ExceptionType satisfies Exception {
        return ExpectedExceptionRequirement<Input,Output,ExceptionType>( startingValues, setup );
    }
    
    "Defines a requirement that expects a nonexistent outcome."
    shared Requirement expectNonexistentResult() {
        return NonexistenceRequirement<Input,Output>( startingValues, setup );
    }
    
    "Augments the set up operation of this behavior to produce a new behavior with composed set up operation."
    shared Behavior<Input,Output2> followedBy<Output2>(
        "A second transform to be applied before the final result is constrained"
        Output2 setup2( Output input2 ) 
    ) {
        return Behavior<Input,Output2>( startingValues, compose(setup2, setup) );
    }
    
}
