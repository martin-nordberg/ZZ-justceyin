
import org.justceyin.expectations.constraints { 
    Constraint 
}

"Adapter class wraps an expectation and throws an assertion if it fails when checked."
by "Martin E. Nordberg III"
shared class AssertedExpectation<T>( 
    Expectation<T> expectation 
) 
    given T satisfies Object
{
    
    "Provides a value name to be used in messages arising from the constraint built by this expectation."
    shared AssertedExpectation<T> named( 
        "The name of the value for use in constraint checking result messages."
        String valueName 
    ) {
        return AssertedExpectation( expectation.named(valueName) );
    }
    
    "Performs a constraint check, giving back a constraint check result."
    shared void toBe(
        "The constraint to check against the actual value of this expectation." 
        Constraint<T> constraint 
    ) {
        value result = expectation.toBe( constraint );
        
        if ( !result.isSuccess ) {
            throw AssertionException( result.message );
        }
    }
    
    "Performs a constraint check if a value exists; gives back a constraint check result, 
     succeeding if the tested actual value does not exist."
    shared void toOptionallyBe( 
        "The constraint to check against the actual value of this expectation (but only if it exists)." 
        Constraint<T> constraint 
    ) {
        value result = expectation.toOptionallyBe( constraint );
        
        if ( !result.isSuccess ) {
            throw AssertionException( result.message );
        }
    }

    "Performs a constraint check on a value that is expected to not exist."
    shared void toNotExist() {
        value result = expectation.toNotExist();
        
        if ( !result.isSuccess ) {
            throw AssertionException( result.message );
        }
    }
    
}