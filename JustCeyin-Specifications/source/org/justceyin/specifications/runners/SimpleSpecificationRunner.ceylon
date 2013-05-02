
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.specifications { 
    Specification 
}

"Simple specification runner that executes a (possibly composite) specification."
shared class SimpleSpecificationRunner( Specification specification )
    satisfies SpecificationRunner
{

    "Runs this runner on its given specification."
    shared actual ConstraintCheckResult run() =>
        specification.check();

}
