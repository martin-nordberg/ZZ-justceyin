
import org.justceyin.expectations.constraints {
    ConstraintCheckComposite, 
    ConstraintCheckFailure, 
    ConstraintCheckResult, 
    ConstraintCheckSuccess 
}

"A requirement defined in terms of a starting point, a set up (transform) operation, and an exception
 that is expected to be thrown by the setup/transform process."
by "Martin E. Nordberg III"
shared class ExpectedExceptionRequirement<Input,Output,ExceptionType>(
    "Functions providing starting values to be checking for this requirement."
    {Input()+} startingValues, 
    "A transform operation to be applied to each starting value."
    Output setup( Input input ) 
)
    satisfies Requirement
    given ExceptionType satisfies Exception
{
    
    "Executes a given setup transform from a given starting point provider and catched the expected exception."
    ConstraintCheckResult expectException( Output setup( Input input ) )( Input() startingValue ) {
        try {
            setup( startingValue() );
            return ConstraintCheckFailure( "Expected an exception of type TBD." );
        }
        catch ( Exception e ) {
            if ( is ExceptionType e ) {
                return ConstraintCheckSuccess( "Verified an exception of type TBD is thrown." );
            }
            return ConstraintCheckFailure( "Expected an exception of type TBD, but caught exception of type TBD." );
        }
    }
    
    "Tests whether the requirement has been met for the given input, set up, and expected outcome."
    shared actual ConstraintCheckResult check(
        "The title of this requirement for use as the text of a composite constraint checking result"
        String title 
    ) {
        return ConstraintCheckComposite( 
                   title, 
                   startingValues.collect( expectException(setup) ) 
               );
    }
    
}
