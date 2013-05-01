
import org.justceyin.expectations.constraints { 
    BasicConstraint,
    Constraint 
}

"Mixin class defines constraints on a category."
by "Martin E. Nordberg III"
shared interface CategoryConstraints<T>
    given T satisfies Category
{
	
    "Returns a constraint that checks whether a category contains a given item."
    shared Constraint<T> thatContains(
        "The object expected to be contained in a tested category."
        Object element 
    ) {
        return BasicConstraint<T>( 
            (T category) => category.contains( element ),
            (String valueName) => "Verified ``valueName`` contains '``element``'.",
		    (T category, String valueName) => "Expected ``valueName`` to contain \"``element``\", but was \"``category``\".", 
		    (T category, String valueName) => "An exception occurred while checking whether ``valueName`` (= \"``category``\") contains ``element``." 
        );            
    }

    "Returns a constraint that checks whether a category contains any one of a given list of items."
    shared Constraint<T> thatContainsAnyElementOf(
        "The objects, one of which is expected to be contained in a tested category."
        {Object*} elements 
    ) {
        return BasicConstraint<T>( 
            (T category) => category.containsAny( elements ),
            (String valueName) => "Verified ``valueName`` contains one of ``elements``.",
		    (T category, String valueName) => "Expected ``valueName`` to contain one of ``elements``, but was \"``category``\".", 
		    (T category, String valueName) => "An exception occurred while checking whether ``valueName`` (= \"``category``\") contains one of ``elements``." 
        );            
    }

    "Returns a constraint that checks whether a category contains every item in a given list of items."
    shared Constraint<T> thatContainsEveryElementOf( 
        "The objects, all of which are expected to be contained in a tested category."
        {Object*} elements 
    ) {
        return BasicConstraint<T>( 
            (T category) => category.containsEvery( elements ),
            (String valueName) => "Verified ``valueName`` contains all of ``elements``.",
		    (T category, String valueName) => "Expected ``valueName`` to contain all of ``elements``, but was \"``category``\".", 
		    (T category, String valueName) => "An exception occurred while checking whether ``valueName`` (= \"``category``\") contains all of ``elements``." 
        );            
    }

}

