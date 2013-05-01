
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Concrete object with constraints on Boolean values."
by "Martin E. Nordberg III"
shared object aBoolean
    extends ComparableConstraints<Float>()
    satisfies NumberConstraints<Float>
{
        
    "Returns a constraint that checks that a boolean value is true."
    shared Constraint<Boolean> thatIsTrue =>
        AdjectivalConstraint<Boolean>( (Boolean actualValue) => actualValue, "true" );
     
    "Returns a constraint that checks that a boolean value is false."
    shared Constraint<Boolean> thatIsFalse =>
        AdjectivalConstraint<Boolean>( (Boolean actualValue) => !actualValue, "false" );
     
}