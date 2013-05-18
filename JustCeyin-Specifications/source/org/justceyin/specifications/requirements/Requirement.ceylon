
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}

"Defines a single requirement specification."
by "Martin E. Nordberg III"
shared interface Requirement {
    
    "Checks whether the requirement is satisfied."
    shared formal ConstraintCheckResult check(
        "The title of this requirement - to appear in constraint checking results."
        String title 
    );
    
}
