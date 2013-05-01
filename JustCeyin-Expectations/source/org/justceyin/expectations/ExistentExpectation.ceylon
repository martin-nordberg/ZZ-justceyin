
import org.justceyin.expectations.constraints { 
    Constraint,
    ConstraintCheckResult, 
    ConstraintCheckUnexpectedNull
}


"Class forms the start of a fluent interface API for declarative constraints within BDD specifications."
by "Martin E. Nordberg III"
shared class ExistentExpectation<T>(
    "An actual value to be tested against a constraint."
    T actualValue, 
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
        return ExistentExpectation( actualValue, valueName );
    }
    
    "Performs a constraint check, giving back a constraint check result."
    shared actual ConstraintCheckResult toBe(
        "The constraint to check against the actual value of this expectation." 
        Constraint<T> constraint 
    ) {
        return constraint.check( actualValue, valueName );
    }
    
    "Performs a constraint check if a value exists; gives back a constraint check result, 
     succeeding if the tested actual value does not exist."
    shared actual ConstraintCheckResult toOptionallyBe( 
        "The constraint to check against the actual value of this expectation (but only if it exists)." 
        Constraint<T> constraint 
    ) {
        return constraint.check( actualValue, valueName );
    }

    "Performs a constraint check on a value that is expected to not exist."
    shared actual ConstraintCheckResult toNotExist() {
        return ConstraintCheckUnexpectedNull( "Expected ``valueName`` to not exist, but is ``actualValue``." );
    }

}


