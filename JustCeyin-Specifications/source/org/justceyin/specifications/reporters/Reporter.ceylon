
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}

"Interface to a reporter of constraint checking results."
shared interface Reporter {
    
    "Runs the reporter to produce its output text."
    shared formal String report( ConstraintCheckResult constraintCheckResult );
    
}

// TBD: report to output stream
