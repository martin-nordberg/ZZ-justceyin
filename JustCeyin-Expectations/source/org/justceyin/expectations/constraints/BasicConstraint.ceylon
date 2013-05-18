
"Common higher order constraint that computes a test result from a predicate and a function that 
 computes the message when needed for a failure."
by "Martin E. Nordberg III"
shared class BasicConstraint<T>( 
    "A function that checks the constraint against an actual value."
    Boolean checkCondition(T actualValue),
    "A function that computes the result message when the constraint check succeeds."
    String makeSuccessMessage( String valueName ), 
    "A function that computes the result message when the constraint check fails."
    String makeFailureMessage( T actualValue, String valueName ),
    "A function that computes the result message when the constraint check throws an exception."
    String makeExceptionMessage( T actualValue, String valueName ) 
)
    satisfies Constraint<T>
{
	
	"Applies the constraint by calling the predicate and then computing the message according to the outcome."
	shared actual ConstraintCheckResult check( 
	    "The actual value (or comparable value) to compare against."
	    T actualValue, 
	    "The name of the value for use in the output message."
	    String valueName 
	) {
		try {
	        if ( checkCondition( actualValue ) ) {
			    return ConstraintCheckSuccess( makeSuccessMessage( valueName ) );
		    }
			return ConstraintCheckFailure( makeFailureMessage( actualValue, valueName ) );
		}
		catch ( Exception e ) {
			return ConstraintCheckUnexpectedException( makeExceptionMessage( actualValue, valueName ), e );
		}
	}

}
