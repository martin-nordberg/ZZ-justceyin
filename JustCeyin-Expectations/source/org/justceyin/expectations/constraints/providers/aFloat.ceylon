
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Concrete object with constraints on floating point numbers."
by "Martin E. Nordberg III"
shared object aFloat 
    extends ComparableConstraints<Float>()
    satisfies NumberConstraints<Float>
{
        
    "Returns a constraint that checks that a floating point value is finite."
    shared Constraint<Float> thatIsFinite =>
        AdjectivalConstraint<Float>( (Float actualValue) => actualValue.finite, "finite" );
     
    "Returns a constraint that checks that a floating point value is infinite."
    shared Constraint<Float> thatIsInfinite =>
        AdjectivalConstraint<Float>( (Float actualValue) => actualValue.infinite, "infinite" );

    "Returns a constraint that checks that a floating point value is undefined."
    shared Constraint<Float> thatIsUndefined =>
        AdjectivalConstraint<Float>( (Float actualValue) => actualValue.undefined, "undefined" );
     
    "Returns a constraint that checks that a floating point value is not undefined."
    shared Constraint<Float> thatIsNotUndefined =>
        AdjectivalConstraint<Float>( (Float actualValue) => !actualValue.undefined, "defined" );
     
    "Returns a constraint that checks that a floating point value is strictly negative (less than 0)."
    shared Constraint<Float> thatIsStrictlyNegative =>
        AdjectivalConstraint<Float>( (Float actualValue) => actualValue.strictlyNegative, "strictly negative" );

    "Returns a constraint that checks that a floating point value is strictly positive (greater than 0)."
    shared Constraint<Float> thatIsStrictlyPositive =>
        AdjectivalConstraint<Float>( (Float actualValue) => actualValue.strictlyPositive, "strictly positive" );

}
