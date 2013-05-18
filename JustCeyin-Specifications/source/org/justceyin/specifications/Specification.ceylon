
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}

"Interface defining a specification - an executable object that returns a constraint checking result."
by "Martin E. Nordberg III"
shared interface Specification {
	
	"Tests whether this specification has been met."
    shared formal ConstraintCheckResult check();
	
}

"Top level helper function tests whether a specification has been met."
shared ConstraintCheckResult checkSpecification( Specification specification ) =>
    specification.check();
