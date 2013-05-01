
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Mixin constraint interface for checking number values - positive and negative."
by "Martin E. Nordberg III"
shared interface NumberConstraints<T>
    given T satisfies Number
{
     
    "Returns a constraint that checks that a number is negative (less than 0)."
    shared Constraint<T> thatIsNegative =>
        AdjectivalConstraint<T>( (T actualValue) => actualValue.negative, "negative" );

    "Returns a constraint that checks that a number is not negative (0 or positive)."
    shared Constraint<T> thatIsNotNegative =>
        AdjectivalConstraint<T>( (T actualValue) => !actualValue.negative, "not negative" );

    "Returns a constraint that checks that a number is positive (greater than 0)."
    shared Constraint<T> thatIsPositive =>
        AdjectivalConstraint<T>( (T actualValue) => actualValue.positive, "positive" );

    "Returns a constraint that checks that a number is not positive (0 or negative)."
    shared Constraint<T> thatIsNotPositive => 
        AdjectivalConstraint<T>( (T actualValue) => !actualValue.positive, "not positive" );

}
