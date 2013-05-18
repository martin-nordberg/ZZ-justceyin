
import org.justceyin.expectations.constraints { 
    Constraint,
    ConstraintCheckResult, 
    ConstraintCheckUnexpectedNull, 
    ConstraintCheckSuccess
}


"Class forms the start of a fluent interface API for declarative constraints within BDD specifications."
by "Martin E. Nordberg III"
shared class NonexistentExpectation<T>(
    "The name of the value for use in constraint checking result messages."
    String valueName="value" 
) 
    satisfies Expectation<T>
    given T satisfies Object
{
    
    "Provides a value name to be used in messages arising from the constraint built by this expectation."
    shared actual Expectation<T> named( 
        "The name of the value for use in constraint checking result messages."
        String valueName 
    ) {
        return NonexistentExpectation<T>( valueName );
    }
    
    "Performs a constraint check, giving back a constraint check result."
    shared actual ConstraintCheckResult toBe(
        "The constraint to check against the actual value of this expectation." 
        Constraint<T> constraint 
    ) {
        if ( valueName == "value" ) {
            return ConstraintCheckUnexpectedNull( "Expected a nonexistent value." );
        }
        
        return ConstraintCheckUnexpectedNull( "Expected a nonexistent value for ``valueName``." );
    }
    
    "Performs a constraint check if a value exists; gives back a constraint check result, 
     succeeding if the tested actual value does not exist."
    shared actual ConstraintCheckResult toOptionallyBe( 
        "The constraint to check against the actual value of this expectation (but only if it exists)." 
        Constraint<T> constraint 
    ) {
        return ConstraintCheckSuccess( "Ignored nonexistent but optional ``valueName``." );
    }

    "Performs a constraint check on a value that is expected to not exist."
    shared actual ConstraintCheckResult toNotExist() {
        return ConstraintCheckSuccess( "Verified that ``valueName`` does not exist." );
    }

}


