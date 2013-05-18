
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
	shared Constraint<T> withValue(
	    "The value that test values are expected to be equal to." 
	    T expectedValue 
	) {
		return ComparisonConstraint<T>( 
		    (T actualValue) => actualValue == expectedValue, "equal to", expectedValue
		);
    }

}
	