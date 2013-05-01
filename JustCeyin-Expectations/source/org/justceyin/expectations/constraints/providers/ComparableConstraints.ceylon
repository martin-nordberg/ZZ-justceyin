
import org.justceyin.expectations.constraints { 
    ComparisonConstraint, 
    Constraint 
}

"Concrete constraint class for checking comparable values - less than, greater than, etc."
by "Martin E. Nordberg III"
shared abstract class ComparableConstraints<T>()
    extends EqualityConstraints<T>()
    given T satisfies Comparable<T>
{
	 
	"Returns a constraint that checks that the actual value is greater than a comparable value."
	shared Constraint<T> greaterThan(
	    "The value which a test value is expected to be greater than." 
	    T comparableValue
	) {
		return ComparisonConstraint<T>( 
		    (T actualValue) => actualValue > comparableValue, "greater than", comparableValue
	 	);
	}
	
	"Returns a constraint that checks that the actual value is greater than or equal to a comparable value."
	shared Constraint<T> greaterThanOrEqualTo( 
        "The value which a test value is expected to be greater than or equal to." 
	    T comparableValue 
	) {
		return ComparisonConstraint<T>( 
		    (T actualValue) => actualValue >= comparableValue, "greater than or equal to", comparableValue
	 	);
	}
	
	"Returns a constraint that checks that the actual value is less than a comparable value."
	shared Constraint<T> lessThan( 
        "The value which a test value is expected to be less than." 
	    T comparableValue 
	) {
		return ComparisonConstraint<T>( 
		    (T actualValue) => actualValue < comparableValue, "less than", comparableValue
	 	);
	}

	"Returns a constraint that checks that the actual value is less than or equal to a comparable value."
	shared Constraint<T> lessThanOrEqualTo( 
        "The value which a test value is expected to be less than." 
	    T comparableValue 
	) {
		return ComparisonConstraint<T>( 
		    (T actualValue) => actualValue <= comparableValue, "less than or equal to", comparableValue
	 	);
	}
	
}
