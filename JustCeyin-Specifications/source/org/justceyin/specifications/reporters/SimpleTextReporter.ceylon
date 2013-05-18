
import org.justceyin.expectations.constraints { 
    ConstraintCheckComposite, 
    ConstraintCheckResult
}

"Returns a string of blanks with length double the given indent level."
String indent(
    "The number of indent levels needed"
    Integer indentLevel 
) {
    value blanks = "                                  ";
    return blanks.segment( 0 , 2*indentLevel );
}
    
"Recursively builds the hierarchically indented report from a given constraint check result. Recurses
 through children of a composite constraint checking result."
String buildReport(
    "The partial report built so far"
    String partial, 
    "The next constraint checking result to be reported (recursively if it is composite)"
    ConstraintCheckResult constraintCheckResult, 
    "The current indent level"
    Integer indentLevel 
) {
    
    variable String result = partial + indent(indentLevel) + constraintCheckResult.message + "\n";
    
    if ( is ConstraintCheckComposite constraintCheckResult ) {
        Integer nextIndentLevel = indentLevel + 1;

        String addIndentedChild( String partial, ConstraintCheckResult elem ) {
            return buildReport(partial, elem, nextIndentLevel);
        }
    
        result = constraintCheckResult.childConstraintCheckResults.fold( result, addIndentedChild );
    }
    
    return result;
}

"Reporter produces simple indented text of the constraint checking result messages."
shared class SimpleTextReporter()
    satisfies Reporter
{
    
    "Runs the reporter to produce its output text."
    shared actual String report(
        "The constraint checking result to be reported"
        ConstraintCheckResult constraintCheckResult 
    ) {
        return buildReport( "", constraintCheckResult, 0 );
    }
    
}
