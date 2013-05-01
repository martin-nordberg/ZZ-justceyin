
"Constraint class represents a conjunction of two individual constraints."
by "Martin E. Nordberg III"
shared class AndConstraint<T>(
    "The first constraint to check."
    Constraint<T> constraint1,
    "The second constraint to also check if the first succeeds."
    Constraint<T> constraint2
)
    satisfies Constraint<T>
{
    
    "Checks this constraint against a given actual value with an optional name of that value 
     for use in message output. Ensures that both the first constraint is satisfied and the second one is."
    shared actual ConstraintCheckResult check(
        "An actual value to compare against the condition of the constraint." 
        T actualValue, 
        "The name of the value for use in outcome result messages."
        String valueName
    ) {
        value result1 = constraint1.check( actualValue, valueName );
        if ( !result1.isSuccess ) {
            return result1;
        }
        value result2 = constraint2.check( actualValue, valueName );
        if ( !result2.isSuccess ) {
            return result2;
        }
        return ConstraintCheckSuccess( result1.message + " -AND- " + result2.message );
    }

}
    