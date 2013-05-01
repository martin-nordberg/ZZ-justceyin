
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Concrete object supplying constraints on strings"
by "Martin E. Nordberg III"
shared object aString
    extends ComparableConstraints<String>()
    satisfies CategoryConstraints<String> & ListConstraints<String,Character>
{
    
    "Returns a constraint that checks that a string is longer than a given length."
    shared Constraint<String> longerThan(
        "One less than the minimum length expected for strings tested by this constraint."
        Integer belowMinimumLength 
    ) {
        return AdjectivalConstraint<String>( 
            (String string) => string.longerThan( belowMinimumLength ),
            "longer than ``belowMinimumLength``"
        );
    }            

    "Returns a constraint that checks that a string is shorter than a given length."
    shared Constraint<String> shorterThan( 
        "One more than the maximum length expected for strings tested by this constraint."
        Integer aboveMaximumLength 
    ) {
        return AdjectivalConstraint<String>( 
            (String string) => string.shorterThan( aboveMaximumLength ),
            "shorter than ``aboveMaximumLength``"
        );
    }

    "Returns a constraint that checks that a string is not empty and is shorter than or equal in length to a given value."
    shared Constraint<String> thatIsNotEmptyWithMaximumLength(
        "The maximum length expected for strings tested by this constraint."
        Integer maximumLength 
    ) {
        return AdjectivalConstraint<String>( 
            (String string) => string.longerThan( 0 ) && string.shorterThan( maximumLength+1 ),
            "at most ``maximumLength`` in length"
        );
    }
    
    "Returns a constraint that checks that a string is shorter than or equal in length to a given value."
    shared Constraint<String> withMaximumLength( 
        "The maximum length expected for strings tested by this constraint."
        Integer maximumLength 
    ) {
        return AdjectivalConstraint<String>( 
            (String string) => string.shorterThan( maximumLength+1 ),
            "at most ``maximumLength`` in length"
        );
    }
    
    "Returns a constraint that checks that a string is longer than or equal in length to a given value."
    shared Constraint<String> withMinimumLength( 
        "The minimum length expected for strings tested by this constraint."
        Integer minimumLength 
    ) {
        return AdjectivalConstraint<String>( 
            (String string) => string.longerThan( minimumLength-1 ),
            "at least ``minimumLength`` in length"
        );
    }
    
}
