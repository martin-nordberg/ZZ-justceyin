
"Interface defining the behavior of a constraint. A constraint checks an actual value (of type T) 
 and returns a result indicating success, failure, or unexpected exception."
by "Martin E. Nordberg III"
shared interface Constraint<T> {
	
	"Checks this constraint against a given actual value with an optional name of that value 
	 for use in message output."
	shared formal ConstraintCheckResult check(
	    "An actual value to compare against the condition of the constraint." 
	    T actualValue, 
	    "The name of the value for use in outcome result messages."
	    String valueName = "value" 
	);
	
	"Builds a new constraint that is the conjunction of this constraint and another."
	shared AndConstraint<T> and(
	    "The second constraint that must be satisfied."
	    Constraint<T> otherConstraint
	) {
		return AndConstraint<T>( this , otherConstraint );
	}

    "Builds a new constraint that is the disjunction of this constraint and another."
    shared OrConstraint<T> or(
        "The second constraint that must be satisfied if this one is not."
        Constraint<T> otherConstraint
    ) {
        return OrConstraint<T>( this , otherConstraint );
    }

}


"Top level helper function for checking a constraint against a given actual value with an 
 optional name of that value for use in message output."
by "Martin E. Nordberg III"
shared ConstraintCheckResult checkConstraint<T>(
    "The constraint to check."
    Constraint<T> constraint, 
    "An actual value to compare against the condition of the constraint." 
    T actualValue, 
    "The name of the value for use in outcome result messages."
    String valueName = "value" 
) {
    return constraint.check( actualValue, valueName );
}
