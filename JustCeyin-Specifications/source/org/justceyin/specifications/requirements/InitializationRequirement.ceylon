
import org.justceyin.expectations.constraints { 
    ConstraintCheckComposite, 
    ConstraintCheckResult, Constraint
}

"Requirement represented by an expected constraint on a given set of starting values."
by "Martin E. Nordberg III"
shared class InitializationRequirement<Input>(
    "Functions providing starting values for the requirement."
    {Input()+} startingValues, 
    "A constraint that should apply directly to each starting value."
    Constraint<Input> constraint 
)
    satisfies Requirement
{
    
    "Tests whether the constraint has been met."
    shared actual ConstraintCheckResult check(
        "The title of this requirement - to appear as the message for a composite constraint checking result."
        String title 
    ) {
        return ConstraintCheckComposite( 
                   title, 
                   startingValues.collect( (Input() startingValue) => constraint.check( startingValue() ) ) 
               );
    }
    
}
