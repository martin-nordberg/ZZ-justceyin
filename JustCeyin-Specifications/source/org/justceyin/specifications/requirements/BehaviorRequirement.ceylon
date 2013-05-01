
import org.justceyin.expectations.constraints {
    Constraint, 
    ConstraintCheckComposite, 
    ConstraintCheckResult 
}

"A requirement defined in terms of a starting point, a set up (transform) operation, and an expected outcome
 that is represented in a constraint checking function."
by "Martin E. Nordberg III"
shared class BehaviorRequirement<Input,Output>(
    "Functions providing starting values to be checking for this requirement."
    {Input()+} startingValues, 
    "A transform operation to be applied to each starting value."
    Output setup( Input input ), 
    "A constraint that should be satisfied by each transformed output value."
    Constraint<Output> constraint 
)
    satisfies Requirement 
{
    
    "Tests whether the requirement has been met for the given input, set up, and expected outcome."
    shared actual ConstraintCheckResult check(
        "The title of this requirement for use as the text of a composite constraint checking result"
        String title 
    ) {
        return ConstraintCheckComposite( 
                   title, 
                   startingValues.collect( (Input() startingValue) => setup( startingValue() ))
                                 .collect( (Output transformedValue) => constraint.check(transformedValue) ) 
               );
    }
    
}
