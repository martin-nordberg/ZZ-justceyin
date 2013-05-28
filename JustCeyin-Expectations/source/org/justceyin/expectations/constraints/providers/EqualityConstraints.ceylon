
import org.justceyin.expectations.constraints { 
    ComparisonConstraint, 
    Constraint 
}

"Concrete constraint class enforces equality of an actual value with an expected value."
by "Martin E. Nordberg III"
shared abstract class EqualityConstraints<T>()
    given T satisfies Object
{
	
    "Returns a constraint that checks that an actual value equals an expected value."
    shared Constraint<T> equalTo(
        "The value that test values are expected to be equal to." 
        T expectedValue 
    ) {
        return ComparisonConstraint<T>( 
            (T actualValue) => actualValue == expectedValue, "equal to", expectedValue
        );
    }

    "Returns a constraint that checks that an actual value does not equal an expected value."
    shared Constraint<T> notEqualTo(
        "The value that test values are expected to be different from." 
        T expectedValue 
    ) {
        // TBD: include the actual value in the success message
        
        return ComparisonConstraint<T>( 
            (T actualValue) => actualValue != expectedValue, "not equal to", expectedValue
        );
    }

    "Returns a constraint that checks that an actual value equals an expected value (synonym for equalTo)."
    shared Constraint<T> withValue(
        "The value that test values are expected to be equal to." 
        T expectedValue 
    ) {
        return ComparisonConstraint<T>( 
            (T actualValue) => actualValue == expectedValue, "equal to", expectedValue
        );
    }

}
	