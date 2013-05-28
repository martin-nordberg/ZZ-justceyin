
import ceylon.math.whole {
    Whole
}
import org.justceyin.expectations.constraints.providers { 
    ComparableConstraints, 
    IntegralConstraints, 
    NumberConstraints
}


"Constraints on whole numbers"
shared object aWholeNumber
    extends ComparableConstraints<Whole>()
    satisfies NumberConstraints<Whole> & IntegralConstraints<Whole> 
{
}