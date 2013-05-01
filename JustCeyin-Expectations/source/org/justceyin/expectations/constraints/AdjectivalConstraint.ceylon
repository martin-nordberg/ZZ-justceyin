
"A constraint with messages expressed in terms of a simple adjective like 'empty' or 'ready'."
by "Martin E. Nordberg III"
shared class AdjectivalConstraint<T>( 
    "A function that checks the constraint against an actual value."
    Boolean checkCondition(T actualValue), 
    "The text of the adjective to use in building result messages."
    String adjective 
) 
    extends BasicConstraint<T> (
        checkCondition,
        (String valueName) => "Verified ``valueName`` to be ``adjective``.",
        (T actualValue, String valueName) => "Expected ``valueName`` to be ``adjective``, but was ``actualValue``.", 
        (T actualValue, String valueName) => "An exception occurred while checking whether ``valueName`` is ``adjective``."
    )
    given T satisfies Object 
{

}
