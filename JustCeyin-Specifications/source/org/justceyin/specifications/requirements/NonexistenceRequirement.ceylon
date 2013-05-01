
import org.justceyin.expectations.constraints {
    ConstraintCheckComposite, 
    ConstraintCheckFailure, 
    ConstraintCheckResult, 
    ConstraintCheckSuccess 
}

"A requirement defined in terms of a starting point, a set up (transform) operation with the output 
 expected to be null."
by "Martin E. Nordberg III"
shared class NonexistenceRequirement<Input,Output>(
    "Functions providing starting values to be checking for this requirement."
    {Input()+} startingValues, 
    "A transform operation to be applied to each starting value."
    Output setup( Input input ) 
)
    satisfies Requirement
{
    
    "Executes a given setup transform from a given starting point provider and catched the expected exception."
    ConstraintCheckResult expectNull( Output setup( Input input ) )( Input() startingValue ) {
        Output result = setup( startingValue() );
        if ( exists result ) {
            return ConstraintCheckFailure( "Expected a nonexistent value, but was ``result``." );
        }
        return ConstraintCheckSuccess( "Verified that value does not exist." );
    }
    
    "Tests whether the requirement has been met for the given input, set up, and expected outcome."
    shared actual ConstraintCheckResult check(
        "The title of this requirement for use as the text of a composite constraint checking result"
        String title 
    ) {
        return ConstraintCheckComposite( 
                   title, 
                   startingValues.collect( expectNull(setup) ) 
               );
    }
    
}
