
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}

"Interface to a specification runner."
shared interface SpecificationRunner {
        
    "Runs this runner on its given specifications."
    shared formal ConstraintCheckResult run();

}

// TBD: Add execution time to the result in some way
