
import org.justceyin.expectations.constraints { 
    Constraint 
}

"Starting point for a fluent interface declarative specification constraining multiple starting values."
by "Martin E. Nordberg III"
shared class StartingFromAnyOf<Input>(
    "Sequence of functions providing starting values for a requirement."
    {Input()+} startingValues 
) {
    
    "Expands the specification with a set up (transform) operation to be applied to the starting value(s)."
    shared Behavior<Input,Output> after<Output>( Output setup( Input input ) ) =>
        Behavior<Input,Output>( startingValues, setup );
    
    "Declares a specification via a constraint on the starting value itself."
    shared Requirement expect( Constraint<Input> constraint ) =>
        InitializationRequirement<Input>( startingValues, constraint );

    "Augments the starting point with an additional starting value."
    shared StartingFromAnyOf<Input> or( Input startingValue() ) =>
        StartingFromAnyOf<Input>( {startingValue, *startingValues} );

}
