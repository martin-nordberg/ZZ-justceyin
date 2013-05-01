import org.justceyin.expectations.constraints { AdjectivalConstraint, Constraint }

"Mixin constraint interface for checking integral values - tests for zero and unit."
by "Martin E. Nordberg III"
shared interface IntegralConstraints<T>
    given T satisfies Integral<T>
{
     
    "Returns a constraint that checks that an integral value is zero."
    shared Constraint<T> thatIsZero =>
        AdjectivalConstraint<T>( (T actualValue) => actualValue.zero, "zero" );
     
    "Returns a constraint that checks that an integral value is not zero."
    shared Constraint<T> thatIsNonzero =>
        AdjectivalConstraint<T>( (T actualValue) => !actualValue.zero, "nonzero" );
     
    "Returns a constraint that checks that an integral value is unit (one)."
    shared Constraint<T> thatIsUnit =>
        AdjectivalConstraint<T>( (T actualValue) => actualValue.unit, "unit" );
     
    "Returns a constraint that checks that an integral value is not zero."
    shared Constraint<T> thatIsNotUnit =>
        AdjectivalConstraint<T>( (T actualValue) => !actualValue.unit, "not unit" );
     
}
