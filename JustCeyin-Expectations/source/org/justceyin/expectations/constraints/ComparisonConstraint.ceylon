
"Typical higher order constraint that produces standard messages for comparing an actual and comparable value."
by "Martin E. Nordberg III"
shared class ComparisonConstraint<T>( 
    "Predicate that checks whether the comparison is satisfied."
    Boolean checkCondition(T actualValue),
    "Adjectival prefix for building the comparsion outcome message, e.g. 'less than' or 'near'."
    String comparisonText,
    "The value to compare to"
    T comparableValue 
)
    extends AdjectivalConstraint<T>( 
        checkCondition,
        "``comparisonText`` ``comparableValue``"  
    )
	given T satisfies Object
{

}
