
import org.justceyin.expectations.constraints { 
    Constraint,
    ConstraintCheckResult
}

"Interface for the starting point of a fluent interface API for declarative constraints within BDD specifications."
by "Martin E. Nordberg III"
shared interface Expectation<T>
    of ExistentExpectation<T> | NonexistentExpectation<T>
    given T satisfies Object
{
    
    "Provides a value name to be used in messages arising from the constraint built by this expectation."
    shared formal Expectation<T> named( 
        "The name of the value for use in constraint checking result messages."
        String valueName 
    );
    
    "Performs a constraint check, giving back a constraint check result."
    shared formal ConstraintCheckResult toBe(
        "The constraint to check against the actual value of this expectation." 
        Constraint<T> constraint 
    );
    
    "Performs a constraint check if a value exists; gives back a constraint check result, 
     succeeding if the tested actual value does not exist."
    shared formal ConstraintCheckResult toOptionallyBe( 
        "The constraint to check against the actual value of this expectation (but only if it exists)." 
        Constraint<T> constraint 
    );

    "Performs a constraint check on a value that is expected to not exist."
    shared formal ConstraintCheckResult toNotExist();

}
